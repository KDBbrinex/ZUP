#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий	

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		ЗарплатаКадры.ЗаполнитьПоОснованиюСотрудником(ЭтотОбъект, ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаОстатков, "Объект.ДатаОстатков", Отказ,
		НСтр("ru='Дата остатков'"));
	
	Если НЕ ОстаткиОтпусков.ДокументВводаОстатковОтпусковЗаполненКорректно(ЭтотОбъект) Тогда
		Отказ = Истина;
	КонецЕсли;
	
	СотрудникиДаты = Новый ТаблицаЗначений;
	СотрудникиДаты.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	СотрудникиДаты.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	
	НоваяСтрока = СотрудникиДаты.Добавить();
	НоваяСтрока.Сотрудник = Сотрудник;
	НоваяСтрока.Период = ДатаОстатков;
	
	ЗарплатаКадрыРасширенный.ПроверитьНаличиеДокументовСФиксированнымСдвигомНаДату(СотрудникиДаты, Ссылка, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ДанныеДляПроведения = ДанныеДляПроведения();
	
	ЗарплатаКадрыРасширенный.УстановитьВремяРегистрацииДокумента(Движения, ДанныеДляПроведения.СотрудникиДаты, Ссылка);
	
	ОстаткиОтпусков.СформироватьДвиженияПоложенныхЕжегодныхОтпусков(Ссылка, Движения, ДанныеДляПроведения.ЕжегодныеОтпуска);
	ОстаткиОтпусков.СформироватьДвиженияНачальныхОстатковОтпусков(Движения, ДанныеДляПроведения.ОстаткиОтпусков);
	ОстаткиОтпусков.СформироватьДвиженияОтсутствийСдвигающихРабочийГод(Движения, ДанныеДляПроведения.ОтсутствияСдвигающиеРабочийГод);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеДляПроведения()
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВводНачальныхОстатковОтпусков.Сотрудник КАК Сотрудник,
	|	ВЫБОР
	|		КОГДА ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.ВидЕжегодногоОтпуска.ХарактерЗависимостиДнейОтпуска = ЗНАЧЕНИЕ(Перечисление.ХарактерЗависимостиКоличестваДнейОтпуска.ЗависитОтСтажа)
	|			ТОГДА ДОБАВИТЬКДАТЕ(ВводНачальныхОстатковОтпусков.ДатаОстатков, ДЕНЬ, 1)
	|		ИНАЧЕ ВводНачальныхОстатковОтпусков.ДатаОстатков
	|	КОНЕЦ КАК ДатаСобытия,
	|	ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.ВидЕжегодногоОтпуска КАК ВидЕжегодногоОтпуска,
	|	ВЫБОР
	|		КОГДА ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.Действие = ЗНАЧЕНИЕ(Перечисление.ДействияСЕжегоднымиОтпусками.Отменить)
	|			ТОГДА 0
	|		ИНАЧЕ ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.КоличествоДнейВГод
	|	КОНЕЦ КАК КоличествоДнейВГод,
	|	ВЫБОР
	|		КОГДА ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.Действие = ЗНАЧЕНИЕ(Перечисление.ДействияСЕжегоднымиОтпусками.Отменить)
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК Используется,
	|	ВЫБОР
	|		КОГДА ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.Действие = ЗНАЧЕНИЕ(Перечисление.ДействияСЕжегоднымиОтпусками.Отменить)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ПересчетНеТребуется
	|ИЗ
	|	Документ.ВводНачальныхОстатковОтпусков КАК ВводНачальныхОстатковОтпусков
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ВводНачальныхОстатковОтпусков.ЕжегодныеОтпуска КАК ВводНачальныхОстатковОтпусковЕжегодныеОтпуска
	|		ПО ВводНачальныхОстатковОтпусков.Ссылка = ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.Ссылка
	|ГДЕ
	|	ВводНачальныхОстатковОтпусковЕжегодныеОтпуска.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВводНачальныхОстатковОтпусков.Сотрудник КАК Сотрудник,
	|	ВводНачальныхОстатковОтпусков.ДатаОстатков КАК ДатаОстатка,
	|	ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.ВидЕжегодногоОтпуска КАК ВидЕжегодногоОтпуска,
	|	ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.РабочийГодНачало КАК РабочийГодНачало,
	|	ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.РабочийГодОкончание КАК РабочийГодОкончание,
	|	ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.Остаток КАК КоличествоДней
	|ИЗ
	|	Документ.ВводНачальныхОстатковОтпусков.ОстаткиОтпусковПоРабочимГодам КАК ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ВводНачальныхОстатковОтпусков КАК ВводНачальныхОстатковОтпусков
	|		ПО ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.Ссылка = ВводНачальныхОстатковОтпусков.Ссылка
	|ГДЕ
	|	ВводНачальныхОстатковОтпусковОстаткиОтпусковПоРабочимГодам.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВводНачальныхОстатковОтпусков.Сотрудник КАК Сотрудник,
	|	ВводНачальныхОстатковОтпусков.ДатаОстатков КАК ДатаСобытия
	|ИЗ
	|	Документ.ВводНачальныхОстатковОтпусков КАК ВводНачальныхОстатковОтпусков
	|ГДЕ
	|	ВводНачальныхОстатковОтпусков.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтсутствияСдвигающиеРабочийГод.Ссылка.Сотрудник КАК Сотрудник,
	|	ОтсутствияСдвигающиеРабочийГод.Ссылка.ДатаОстатков КАК ДатаОстатка,
	|	ОтсутствияСдвигающиеРабочийГод.ВидЕжегодногоОтпуска КАК ВидЕжегодногоОтпуска,
	|	ОтсутствияСдвигающиеРабочийГод.Состояние КАК Состояние,
	|	ОтсутствияСдвигающиеРабочийГод.КоличествоДней КАК КоличествоДней
	|ИЗ
	|	Документ.ВводНачальныхОстатковОтпусков.ОтсутствияСдвигающиеРабочийГод КАК ОтсутствияСдвигающиеРабочийГод
	|ГДЕ
	|	ОтсутствияСдвигающиеРабочийГод.Ссылка = &Ссылка";
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ДанныеДляПроведения = Новый Структура; 
	
	// Первый набор данных для проведения - таблица для формирования положенных видов ежегодных отпусков.
	ДвиженияПрав = РезультатыЗапроса[0].Выгрузить();
	ДанныеДляПроведения.Вставить("ЕжегодныеОтпуска", ДвиженияПрав);
	
	// Второй набор данных для проведения - таблица для формирования начальных остатков отпусков.
	ДвиженияОстатков = РезультатыЗапроса[1].Выгрузить();
	ДанныеДляПроведения.Вставить("ОстаткиОтпусков", ДвиженияОстатков);
	
	// Третий набор данных для проведения - таблица для формирования времени регистрации документа.
	СотрудникиДаты = РезультатыЗапроса[2].Выгрузить();
	ДанныеДляПроведения.Вставить("СотрудникиДаты", СотрудникиДаты);
	
	// Третий набор данных для проведения - таблица для формирования отсутствий, сдвигающих рабочий год.
	Отсутствия = РезультатыЗапроса[3].Выгрузить();
	ДанныеДляПроведения.Вставить("ОтсутствияСдвигающиеРабочийГод", Отсутствия);
	
	Возврат ДанныеДляПроведения;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли