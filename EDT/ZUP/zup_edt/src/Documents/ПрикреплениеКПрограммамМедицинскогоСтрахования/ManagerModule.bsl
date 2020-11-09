#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ДляВсехСтрок( ЗначениеРазрешено(Сотрудники.ФизическоеЛицо, NULL КАК ИСТИНА)
	|	) И ЗначениеРазрешено(Организация)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// Прикрепление к программам страхования
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "УправлениеПечатьюБЗККлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ПрикреплениеКПрограммамСтрахования";
	КомандаПечати.Представление = НСтр("ru = 'Прикрепление к программам страхования'");
	
КонецПроцедуры

// Формирует печатные формы
//
// Параметры:
//  (входные)
//    МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//    ПараметрыПечати - Структура - дополнительные настройки печати;
//  (выходные)
//   КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы.
//   ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                             представление - имя области в которой был выведен объект;
//   ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПрикреплениеКПрограммамСтрахования") Тогда
		ТабличныйДокумент = ПечатьПрикреплениеКПрограммамСтрахования(МассивОбъектов, ОбъектыПечати);
		МедицинскоеСтрахованиеПереопределяемый.Печать(ТабличныйДокумент, МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода);
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ПрикреплениеКПрограммамСтрахования", НСтр("ru = 'Прикрепление к программам страхования'"), ТабличныйДокумент);
	КонецЕсли;
	
КонецПроцедуры

Функция ПечатьПрикреплениеКПрограммамСтрахования(МассивОбъектов, ОбъектыПечати)
	
	// получаем данные для печати
	ДанныеДляПечати = ДанныеПрикрепленияКПрограммамСтрахования(МассивОбъектов);
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_МедицинскоеСтрахование_ПрикреплениеКПрограммамСтрахования";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования.ПФ_MXL_ПрикреплениеКПрограммамСтрахования");
	
	ПервыйДокумент = Истина;
	
	Для Каждого ДанныеДокументаДляПечати Из ДанныеДляПечати Цикл
		
		ДанныеДокумента = ДанныеДокументаДляПечати.Значение;
		// Документы нужно выводить на разных страницах.
		Если Не ПервыйДокумент Тогда
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПервыйДокумент = Ложь;
		КонецЕсли;
		
		// Запомним номер строки, с которой начали выводить текущий документ.
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		// Подсчитываем количество страниц документа - для корректного разбиения на страницы.
		ВсегоСтрокДокумента = ДанныеДокумента.Сотрудники.Количество() + ДанныеДокумента.Родственники.Количество();
		
		ОбластьМакетаЗаголовок						= Макет.ПолучитьОбласть("Заголовок");
		ОбластьМакетаНомерСтраницы					= Макет.ПолучитьОбласть("НомерСтраницы");
		ОбластьМакетаШапкаПерваяКолонка				= Макет.ПолучитьОбласть("Шапка|ПерваяКолонка");
		ОбластьМакетаШапкаПрисоединяемаяКолонка		= Макет.ПолучитьОбласть("Шапка|ПрисоединяемаяКолонка");
		ОбластьМакетаСтрокаПерваяКолонка			= Макет.ПолучитьОбласть("Строка|ПерваяКолонка");
		ОбластьМакетаСтрокаПрисоединяемаяКолонка	= Макет.ПолучитьОбласть("Строка|ПрисоединяемаяКолонка");
		ОбластьМакетаПодвал							= Макет.ПолучитьОбласть("Подвал");
		
		// Массив с двумя строками - для разбиения на страницы.
		ВыводимыеОбласти = Новый Массив();
		ВыводимыеОбласти.Добавить(ОбластьМакетаСтрокаПерваяКолонка);
		
		// выводим данные о документе
		ОбластьМакетаЗаголовок.Параметры.Организация = ДанныеДокумента.Организация;
		ОбластьМакетаЗаголовок.Параметры.СтраховаяКомпания = ДанныеДокумента.СтраховаяКомпания;
		
		ТабличныйДокумент.Вывести(ОбластьМакетаЗаголовок);
		
		ВыведеноСтраниц = 1; ВыведеноСтрок = 0;
		
		ОбластьМакетаНомерСтраницы.Параметры.НомерСтраницы = ВыведеноСтраниц;
		ТабличныйДокумент.Вывести(ОбластьМакетаНомерСтраницы);
		
		ТабличныйДокумент.Вывести(ОбластьМакетаШапкаПерваяКолонка);
		
		ВсеПередаваемыеСведения = МедицинскоеСтрахование.ПередаваемыеСведенияВСтраховуюКомпанию();
		ПередаваемыеСведения = МедицинскоеСтрахованиеФормы.ПередаваемыеСведения(,, Истина);
		Для каждого ЭлементСписка Из ПередаваемыеСведения Цикл
			ОбластьМакетаШапкаПрисоединяемаяКолонка.Параметры["ИмяКолонки1"] = ЭлементСписка.Представление;
			ТабличныйДокумент.Присоединить(ОбластьМакетаШапкаПрисоединяемаяКолонка);
		КонецЦикла;
		
		СтраховаяПремияИтого = 0;
		// Выводим данные по строкам документа.
		Страхователи = Новый Структура;
		Страхователи.Вставить("Сотрудники", "Сотрудник");
		Страхователи.Вставить("Родственники", "Родственник");
		
		Для Каждого ЭлементСтруктуры Из Страхователи Цикл
			ИмяПоляСтрахователя = ЭлементСтруктуры.Значение;
			Для Каждого ДанныеДляПечатиСтроки Из ДанныеДокумента[ЭлементСтруктуры.Ключ] Цикл
				
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.ФИО = ДанныеДляПечатиСтроки[ИмяПоляСтрахователя];
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.ПрограммыСтрахования = ДанныеДляПечатиСтроки.ПрограммыСтрахования;
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.РасширенияПрограммСтрахования = ДанныеДляПечатиСтроки.РасширенияПрограммСтрахования;
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.ДатаНачалаСтрахования = ДанныеДляПечатиСтроки.ДатаНачала;
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.ДатаОкончанияСтрахования = ДанныеДляПечатиСтроки.ДатаОкончания;
				ОбластьМакетаСтрокаПерваяКолонка.Параметры.СтраховаяПремия = ДанныеДляПечатиСтроки.СтраховаяПремия;
				СтраховаяПремияИтого = СтраховаяПремияИтого + ДанныеДляПечатиСтроки.СтраховаяПремия;
				
				// разбиение на страницы
				ВыведеноСтрок = ВыведеноСтрок + 1;
				
				// Проверим, уместится ли строка на странице или надо открывать новую страницу.
				ВывестиПодвалЛиста = Не ОбщегоНазначения.ПроверитьВыводТабличногоДокумента(ТабличныйДокумент, ВыводимыеОбласти);
				Если Не ВывестиПодвалЛиста И ВыведеноСтрок = ВсегоСтрокДокумента Тогда
					ОбластьМакетаПодвал.Параметры.СтраховаяПремияИтого = СтраховаяПремияИтого;
					ВыводимыеОбласти.Добавить(ОбластьМакетаПодвал);
					ВывестиПодвалЛиста = Не ОбщегоНазначения.ПроверитьВыводТабличногоДокумента(ТабличныйДокумент, ВыводимыеОбласти);
				КонецЕсли;
				Если ВывестиПодвалЛиста Тогда
					
					ОбластьМакетаПодвал.Параметры.СтраховаяПремияИтого = СтраховаяПремияИтого;
					ТабличныйДокумент.Вывести(ОбластьМакетаПодвал);
					ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
					СтраховаяПремияИтого = 0;
					
					ВыведеноСтраниц = ВыведеноСтраниц + 1;
					
					ОбластьМакетаНомерСтраницы.Параметры.НомерСтраницы = ВыведеноСтраниц;
					ТабличныйДокумент.Вывести(ОбластьМакетаНомерСтраницы);
					
					ТабличныйДокумент.Вывести(ОбластьМакетаШапкаПерваяКолонка);
					Для каждого ЭлементСписка Из ПередаваемыеСведения Цикл
						ОбластьМакетаШапкаПрисоединяемаяКолонка.Параметры["ИмяКолонки1"] = ЭлементСписка.Представление;
						ТабличныйДокумент.Присоединить(ОбластьМакетаШапкаПрисоединяемаяКолонка);
					КонецЦикла;
					
				КонецЕсли;
				
				ТабличныйДокумент.Вывести(ОбластьМакетаСтрокаПерваяКолонка);
				
				Для каждого ЭлементСписка Из ПередаваемыеСведения Цикл
					Если ТипЗнч(ЭлементСписка.Значение) = Тип("Строка") Тогда
						ЗначениеЯчейки = ДанныеДляПечатиСтроки.Сведения[ЭлементСписка.Значение];
					Иначе
						ОтборСведений = Новый Структура("Ссылка", ЭлементСписка.Значение);
						НайденныеСтроки = ВсеПередаваемыеСведения.НайтиСтроки(ОтборСведений);
						Если НайденныеСтроки.Количество() > 0 Тогда
							ЗначениеЯчейки = ДанныеДляПечатиСтроки.Сведения[НайденныеСтроки[0].Имя + "Представление"];
						Иначе
							Продолжить;
						КонецЕсли;
					КонецЕсли;
					Если ТипЗнч(ЗначениеЯчейки) = Тип("Дата") Тогда
						ЗначениеЯчейки = Формат(ЗначениеЯчейки, "ДЛФ=Д");
					КонецЕсли;
					ОбластьМакетаСтрокаПрисоединяемаяКолонка.Параметры["ЗначениеКолонки1"] = ЗначениеЯчейки;
					ТабличныйДокумент.Присоединить(ОбластьМакетаСтрокаПрисоединяемаяКолонка);
				КонецЦикла;
				
			КонецЦикла;
		КонецЦикла;
		
		ОбластьМакетаПодвал.Параметры.СтраховаяПремияИтого = СтраховаяПремияИтого;
		ТабличныйДокумент.Вывести(ОбластьМакетаПодвал);
		
		// В табличном документе необходимо задать имя области, в которую был 
		// выведен объект. Нужно для возможности печати покомплектно.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, ДанныеДокумента.ДокументПрикрепления);
		
	КонецЦикла; // по документам
	
	Возврат ТабличныйДокумент;
	
КонецФункции

// Получает данные для формирования печатного документа.
//
// Параметры:
//		МассивДокументов - Массив ссылок на документы, по которым требуется получить данные.
//
// Возвращаемое значение:
//		Соответствие - где Ключ - ссылка на документ, Значение - структура документа.
//
Функция ДанныеПрикрепленияКПрограммамСтрахования(МассивДокументов)
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("ПрикреплениеКПрограммамМедицинскогоСтрахования", МассивДокументов);
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.Ссылка КАК ДокументПрикрепления,
	|	ПрикреплениеКПрограммамМедицинскогоСтрахования.Организация КАК Организация,
	|	ПрикреплениеКПрограммамМедицинскогоСтрахования.СтраховаяКомпания КАК СтраховаяКомпания,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.Сотрудник КАК Сотрудник,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.ДатаПрикрепления КАК ДатаНачала,
	|	ПрикреплениеКПрограммамМедицинскогоСтрахования.ДатаОкончанияСтрахования КАК ДатаОкончания,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.ПрограммыСтрахования КАК ПрограммыСтрахования,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.РасширенияПрограммСтрахования КАК РасширенияПрограммСтрахования,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.СтраховаяПремия КАК СтраховаяПремия,
	|	МедицинскоеСтрахованиеПрикреплениеСведенияСотрудников.СведениеИмя КАК СведениеИмя,
	|	МедицинскоеСтрахованиеПрикреплениеСведенияСотрудников.СведениеЗначение КАК СведениеЗначение
	|ИЗ
	|	Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования.Сотрудники КАК МедицинскоеСтрахованиеПрикреплениеСотрудники
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования КАК ПрикреплениеКПрограммамМедицинскогоСтрахования
	|		ПО МедицинскоеСтрахованиеПрикреплениеСотрудники.Ссылка = ПрикреплениеКПрограммамМедицинскогоСтрахования.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования.СведенияСотрудников КАК МедицинскоеСтрахованиеПрикреплениеСведенияСотрудников
	|		ПО МедицинскоеСтрахованиеПрикреплениеСотрудники.Ссылка = МедицинскоеСтрахованиеПрикреплениеСведенияСотрудников.Ссылка
	|			И МедицинскоеСтрахованиеПрикреплениеСотрудники.Сотрудник = МедицинскоеСтрахованиеПрикреплениеСведенияСотрудников.Сотрудник
	|ГДЕ
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.Ссылка В(&ПрикреплениеКПрограммамМедицинскогоСтрахования)
	|
	|УПОРЯДОЧИТЬ ПО
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.Ссылка,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.Сотрудник,
	|	МедицинскоеСтрахованиеПрикреплениеСотрудники.ДатаПрикрепления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.Ссылка КАК ДокументПрикрепления,
	|	ПрикреплениеКПрограммамМедицинскогоСтрахования.Организация КАК Организация,
	|	ПрикреплениеКПрограммамМедицинскогоСтрахования.СтраховаяКомпания КАК СтраховаяКомпания,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.Родственник КАК Родственник,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.ДатаПрикрепления КАК ДатаНачала,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.ДатаОткрепления КАК ДатаОкончания,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.ПрограммыСтрахования КАК ПрограммыСтрахования,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.РасширенияПрограммСтрахования КАК РасширенияПрограммСтрахования,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.СтраховаяПремия КАК СтраховаяПремия,
	|	МедицинскоеСтрахованиеПрикреплениеСведенияРодственников.СведениеИмя КАК СведениеИмя,
	|	МедицинскоеСтрахованиеПрикреплениеСведенияРодственников.СведениеЗначение КАК СведениеЗначение
	|ИЗ
	|	Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования.Родственники КАК МедицинскоеСтрахованиеПрикреплениеРодственники
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования КАК ПрикреплениеКПрограммамМедицинскогоСтрахования
	|		ПО МедицинскоеСтрахованиеПрикреплениеРодственники.Ссылка = ПрикреплениеКПрограммамМедицинскогоСтрахования.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПрикреплениеКПрограммамМедицинскогоСтрахования.СведенияРодственников КАК МедицинскоеСтрахованиеПрикреплениеСведенияРодственников
	|		ПО МедицинскоеСтрахованиеПрикреплениеРодственники.Ссылка = МедицинскоеСтрахованиеПрикреплениеСведенияРодственников.Ссылка
	|			И МедицинскоеСтрахованиеПрикреплениеРодственники.ФизическоеЛицо = МедицинскоеСтрахованиеПрикреплениеСведенияРодственников.ФизическоеЛицо
	|			И МедицинскоеСтрахованиеПрикреплениеРодственники.Родственник = МедицинскоеСтрахованиеПрикреплениеСведенияРодственников.Родственник
	|ГДЕ
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.Ссылка В(&ПрикреплениеКПрограммамМедицинскогоСтрахования)
	|
	|УПОРЯДОЧИТЬ ПО
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.Ссылка,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.Родственник,
	|	МедицинскоеСтрахованиеПрикреплениеРодственники.ДатаПрикрепления";
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ДанныеДокументов = Новый Соответствие;
	ВыборкаСотрудников = РезультатыЗапроса[РезультатыЗапроса.ВГраница()-1].Выбрать();
	Пока ВыборкаСотрудников.СледующийПоЗначениюПоля("ДокументПрикрепления") Цикл
		
		ДанныеДокумента = Новый Структура;
		ДанныеДокумента.Вставить("ДокументПрикрепления", ВыборкаСотрудников.ДокументПрикрепления);
		ДанныеДокумента.Вставить("Организация", ВыборкаСотрудников.Организация);
		ДанныеДокумента.Вставить("СтраховаяКомпания", ВыборкаСотрудников.СтраховаяКомпания);
		ДанныеДокумента.Вставить("Сотрудники", Новый Массив);
		ДанныеДокумента.Вставить("Родственники", Новый Массив);
		Пока ВыборкаСотрудников.СледующийПоЗначениюПоля("Сотрудник") Цикл
			ДанныеСотрудника = Новый Структура;
			ДанныеСотрудника.Вставить("Сотрудник", ВыборкаСотрудников.Сотрудник);
			ДанныеСотрудника.Вставить("ДатаНачала", ВыборкаСотрудников.ДатаНачала);
			ДанныеСотрудника.Вставить("ДатаОкончания", ВыборкаСотрудников.ДатаОкончания);
			ДанныеСотрудника.Вставить("ПрограммыСтрахования", ВыборкаСотрудников.ПрограммыСтрахования);
			ДанныеСотрудника.Вставить("РасширенияПрограммСтрахования", ВыборкаСотрудников.РасширенияПрограммСтрахования);
			ДанныеСотрудника.Вставить("СтраховаяПремия", ВыборкаСотрудников.СтраховаяПремия);
			
			ДанныеСведений = Новый Структура;
			Пока ВыборкаСотрудников.Следующий() Цикл
				ДанныеСведений.Вставить(ВыборкаСотрудников.СведениеИмя, ВыборкаСотрудников.СведениеЗначение);
			КонецЦикла;
			
			ДанныеСотрудника.Вставить("Сведения", ДанныеСведений);
			
			ДанныеДокумента.Сотрудники.Добавить(ДанныеСотрудника);
		КонецЦикла;
		
		ДанныеДокументов.Вставить(ВыборкаСотрудников.ДокументПрикрепления, ДанныеДокумента);
		
	КонецЦикла;
	
	ВыборкаРодственников = РезультатыЗапроса[РезультатыЗапроса.ВГраница()].Выбрать();
	Пока ВыборкаРодственников.СледующийПоЗначениюПоля("ДокументПрикрепления") Цикл
		
		ДанныеДокумента = ДанныеДокументов.Получить(ВыборкаРодственников.ДокументПрикрепления);
		Если ДанныеДокумента = Неопределено Тогда
			ДанныеДокумента = Новый Структура;
			ДанныеДокумента.Вставить("ДокументПрикрепления", ВыборкаРодственников.ДокументПрикрепления);
			ДанныеДокумента.Вставить("Организация", ВыборкаРодственников.Организация);
			ДанныеДокумента.Вставить("СтраховаяКомпания", ВыборкаРодственников.СтраховаяКомпания);
			ДанныеДокумента.Вставить("Сотрудники", Новый Массив);
			ДанныеДокумента.Вставить("Родственники", Новый Массив);
		КонецЕсли;
		ДанныеДокумента.Вставить("Родственники", Новый Массив);
		Пока ВыборкаРодственников.СледующийПоЗначениюПоля("Родственник") Цикл
			ДанныеРодственника = Новый Структура;
			ДанныеРодственника.Вставить("Родственник", ВыборкаРодственников.Родственник);
			ДанныеРодственника.Вставить("ДатаНачала", ВыборкаРодственников.ДатаНачала);
			ДанныеРодственника.Вставить("ДатаОкончания", ВыборкаРодственников.ДатаОкончания);
			ДанныеРодственника.Вставить("ПрограммыСтрахования", ВыборкаРодственников.ПрограммыСтрахования);
			ДанныеРодственника.Вставить("РасширенияПрограммСтрахования", ВыборкаРодственников.РасширенияПрограммСтрахования);
			ДанныеРодственника.Вставить("СтраховаяПремия", ВыборкаРодственников.СтраховаяПремия);
			
			ДанныеСведений = Новый Структура;
			Пока ВыборкаРодственников.Следующий() Цикл
				ДанныеСведений.Вставить(ВыборкаРодственников.СведениеИмя, ВыборкаРодственников.СведениеЗначение);
			КонецЦикла;
			
			ДанныеРодственника.Вставить("Сведения", ДанныеСведений);
			
			ДанныеДокумента.Родственники.Добавить(ДанныеРодственника);
		КонецЦикла;
		
		ДанныеДокументов.Вставить(ВыборкаРодственников.ДокументПрикрепления, ДанныеДокумента);
		
	КонецЦикла;
	
	Возврат ДанныеДокументов;
	
КонецФункции

#КонецОбласти

#Область Загрузка

// Устанавливает параметры загрузки.
//
Процедура УстановитьПараметрыЗагрузкиИзФайлаВТЧ(Параметры) Экспорт
	
КонецПроцедуры

// Производит сопоставление данных, загружаемых в табличную часть ПолноеИмяТабличнойЧасти,
// с данными в ИБ, и заполняет параметры АдресТаблицыСопоставления и СписокНеоднозначностей.
//
// Параметры:
//   АдресЗагружаемыхДанных    - Строка - Адрес временного хранилища с таблицей значений, в которой
//                                        находятся загруженные данные из файла. Состав колонок:
//     * Идентификатор - Число - Порядковый номер строки;
//     * остальные колонки соответствуют колонкам макета ЗагрузкаИзФайла.
//   АдресТаблицыСопоставления - Строка - Адрес временного хранилища с пустой таблицей значений,
//                                        являющейся копией табличной части документа, 
//                                        которую необходимо заполнить из таблицы АдресЗагружаемыхДанных.
//   СписокНеоднозначностей - ТаблицаЗначений - Список неоднозначных значений, для которых в ИБ имеется несколько
//                                              подходящих вариантов.
//     * Колонка       - Строка - Имя колонки, в которой была обнаружена неоднозначность;
//     * Идентификатор - Число  - Идентификатор строки, в которой была обнаружена неоднозначность.
//   ПолноеИмяТабличнойЧасти   - Строка - Полное имя табличной части, в которую загружаются данные.
//   ДополнительныеПараметры   - ЛюбойТип - Любые дополнительные сведения.
//
Процедура СопоставитьЗагружаемыеДанные(АдресЗагружаемыхДанных, АдресТаблицыСопоставления, СписокНеоднозначностей, ПолноеИмяТабличнойЧасти, ДополнительныеПараметры) Экспорт
	
	Сотрудники =  ПолучитьИзВременногоХранилища(АдресТаблицыСопоставления);
	
	ЗагружаемыеДанные = ПолучитьИзВременногоХранилища(АдресЗагружаемыхДанных);
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Сотрудник КАК СТРОКА(100)) КАК Сотрудник,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.ПрограммаСтрахования КАК СТРОКА(100)) КАК ПрограммаСтрахования,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.РасширениеПрограммСтрахования КАК СТРОКА(100)) КАК РасширениеПрограммСтрахования,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ ДанныеДляСопоставления
	|ИЗ
	|	&ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(Сотрудники.Ссылка) КАК Сотрудник,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО (Сотрудники.Наименование = ДанныеДляСопоставления.Сотрудник)
	|			И (НЕ Сотрудники.ВАрхиве)
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ПрограммыМедицинскогоСтрахования.Ссылка) КАК ПрограммаСтрахования,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрограммыМедицинскогоСтрахования КАК ПрограммыМедицинскогоСтрахования
	|		ПО (ПрограммыМедицинскогоСтрахования.Наименование = ДанныеДляСопоставления.ПрограммаСтрахования)
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(РасширенияПрограммМедицинскогоСтрахования.Ссылка) КАК РасширениеПрограммСтрахования,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.РасширенияПрограммМедицинскогоСтрахования КАК РасширенияПрограммМедицинскогоСтрахования
	|		ПО (РасширенияПрограммМедицинскогоСтрахования.Наименование = ДанныеДляСопоставления.РасширениеПрограммСтрахования)
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор";
	
	Запрос.УстановитьПараметр("ДанныеДляСопоставления", ЗагружаемыеДанные);
	РезультатыЗапросов = Запрос.ВыполнитьПакет();
	
	ТаблицаСотрудники 	= РезультатыЗапросов[1].Выгрузить();
	ТаблицаПрограммСтрахования = РезультатыЗапросов[2].Выгрузить();
	ТаблицаРасширенийПрограммСтрахования = РезультатыЗапросов[3].Выгрузить();
	
	Для Каждого СтрокаТаблицы Из ЗагружаемыеДанные Цикл
		
		СтрокаСотрудник = Сотрудники.Добавить();
		СтрокаСотрудник.Идентификатор 	= СтрокаТаблицы.Идентификатор;
		СтрокаСотрудник.ДатаПрикрепления= СтроковыеФункцииКлиентСервер.СтрокаВДату(СтрокаТаблицы.ДатаПрикрепления);
		СтрокаСотрудник.СтраховаяПремия	= СтроковыеФункцииКлиентСервер.СтрокаВЧисло(СтрокаТаблицы.СтраховаяПремия);
		
		СтрокаТаблицыСотрудник = ТаблицаСотрудники.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТаблицыСотрудник <> Неопределено Тогда 
			Если СтрокаТаблицыСотрудник.Количество = 1 Тогда 
				СтрокаСотрудник.Сотрудник = СтрокаТаблицыСотрудник.Сотрудник;
			ИначеЕсли СтрокаТаблицыСотрудник.Количество > 1 Тогда
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "Сотрудник";
			КонецЕсли;
		КонецЕсли;
		
		СтрокаТаблицыПрограммСтрахования = ТаблицаПрограммСтрахования.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТаблицыПрограммСтрахования <> Неопределено Тогда
			Если СтрокаТаблицыПрограммСтрахования.Количество = 1 Тогда 
				СтрокаСотрудник.ПрограммаСтрахования = СтрокаТаблицыПрограммСтрахования.ПрограммаСтрахования;
			ИначеЕсли СтрокаТаблицыПрограммСтрахования.Количество > 1 Тогда
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "ПрограммаСтрахования";
			КонецЕсли;
		КонецЕсли;
		
		СтрокаТаблицыРасширенийПрограммСтрахования = ТаблицаРасширенийПрограммСтрахования.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТаблицыРасширенийПрограммСтрахования <> Неопределено Тогда
			Если СтрокаТаблицыРасширенийПрограммСтрахования.Количество = 1 Тогда 
				СтрокаСотрудник.РасширениеПрограммСтрахования = СтрокаТаблицыРасширенийПрограммСтрахования.РасширениеПрограммСтрахования;
			ИначеЕсли СтрокаТаблицыРасширенийПрограммСтрахования.Количество > 1 Тогда
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "РасширениеПрограммСтрахования";
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(Сотрудники, АдресТаблицыСопоставления);
	
КонецПроцедуры

// Возвращает список подходящих объектов ИБ для неоднозначного значения ячейки.
// 
// Параметры:
//   ПолноеИмяТабличнойЧасти  - Строка - Полное имя табличной части, в которую загружаются данные.
//  ИмяКолонки                - Строка - Имя колонки, в который возникла неоднозначность.
//  СписокНеоднозначностей    - Массив - Массив для заполнения с неоднозначными данными.
//  ЗагружаемыеЗначенияСтрока - Строка - Загружаемые данные на основании которых возникла неоднозначность.
//  ДополнительныеПараметры   - ЛюбойТип - Любые дополнительные сведения.
//
Процедура ЗаполнитьСписокНеоднозначностей(ПолноеИмяТабличнойЧасти, СписокНеоднозначностей, ИмяКолонки, ЗагружаемыеЗначенияСтрока, ДополнительныеПараметры) Экспорт
	
	Если ИмяКолонки = "Сотрудник" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	Сотрудники.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Сотрудники КАК Сотрудники
		|ГДЕ
		|	Сотрудники.Наименование = &Наименование";
		
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.Сотрудник);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		
	ИначеЕсли ИмяКолонки = "ПрограммаСтрахования" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПрограммыМедицинскогоСтрахования.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ПрограммыМедицинскогоСтрахования КАК ПрограммыМедицинскогоСтрахования
		|ГДЕ
		|	ПрограммыМедицинскогоСтрахования.Наименование = &Наименование";
		
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.ПрограммаСтрахования);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		
	ИначеЕсли ИмяКолонки = "РасширениеПрограммСтрахования" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РасширенияПрограммМедицинскогоСтрахования.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.РасширенияПрограммМедицинскогоСтрахования КАК РасширенияПрограммМедицинскогоСтрахования
		|ГДЕ
		|	РасширенияПрограммМедицинскогоСтрахования.Наименование = &Наименование";
		
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.РасширениеПрограммСтрахования);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

// См. ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъекта
Функция ОписаниеСоставаОбъекта() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ПрикреплениеКПрограммамМедицинскогоСтрахования;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#КонецЕсли
