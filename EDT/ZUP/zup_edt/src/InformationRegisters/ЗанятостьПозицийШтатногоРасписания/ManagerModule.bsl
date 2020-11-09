
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПодчиненностьПодразделенийОрганизаций КАК Т2 
	|	ПО Т2.Подразделение = Т.ПозицияШтатногоРасписания.Подразделение
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т2.ВышестоящееПодразделение)
	|	И ЗначениеРазрешено(Т.ПозицияШтатногоРасписания.Владелец)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Процедура заполняет интервальный регистр сведений ЗанятостьПозицийШтатногоРасписанияИнтервальный.
//
Процедура ЗаполнитьИнтервальныйРегистр(ПараметрыОбновления = Неопределено) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.ПеренестиВозвратныйРегистрВИнтервальныйРегистрСведений(
		Метаданные.РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.Имя, ПараметрыОбновления);
	
КонецПроцедуры

Процедура ОбновитьДвиженияИнтервальногоРегистра(МенеджерВременныхТаблиц) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.ОбновитьДвиженияИнтервальногоРегистра(
		Метаданные.РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.Имя, МенеджерВременныхТаблиц);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвиженияИнтервальногоРегистраПоМассивуРегистраторов(МассивРегистраторов, ПараметрыОбновления) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("МассивРегистраторов", МассивРегистраторов);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЗанятостьПозицийШтатногоРасписания.Сотрудник КАК Сотрудник,
		|	ЗанятостьПозицийШтатногоРасписания.ДокументОснование КАК ДокументОснование
		|ПОМЕСТИТЬ ВТОтборДляПереформирования
		|ИЗ
		|	РегистрСведений.ЗанятостьПозицийШтатногоРасписания КАК ЗанятостьПозицийШтатногоРасписания
		|ГДЕ
		|	ЗанятостьПозицийШтатногоРасписания.Регистратор В(&МассивРегистраторов)";
	
	Запрос.Выполнить();
	
	ОбновитьДвиженияИнтервальногоРегистра(Запрос.МенеджерВременныхТаблиц);
	
КонецПроцедуры

Функция ОписаниеИнтервальногоРегистра() Экспорт
	
	ОписаниеИнтервальногоРегистра = ЗарплатаКадрыПериодическиеРегистры.ОписаниеИнтервальногоРегистра();
	
	ОписаниеИнтервальногоРегистра.ПараметрыНаследованияРесурсов = ПараметрыНаследованияРесурсов();
	ОписаниеИнтервальногоРегистра.ОсновноеИзмерение = "Сотрудник";
	ОписаниеИнтервальногоРегистра.ИзмеренияРасчета = "Сотрудник, ДокументОснование";
	
	Возврат ОписаниеИнтервальногоРегистра;
	
КонецФункции

Функция ПараметрыНаследованияРесурсов() Экспорт
	Возврат ЗарплатаКадрыПериодическиеРегистры.ПараметрыНаследованияРесурсов(Метаданные.РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.Имя);
КонецФункции

Процедура ЗаполнитьДвиженияПоДаннымВыборкиРегистраторов(Выборка, ДатаОкончанияПланируемая, ПараметрыОбновления) Экспорт
	
	Если Выборка.Количество() = 0 Тогда
		
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбработчик(ПараметрыОбновления);
		Возврат;
		
	КонецЕсли;
	
	ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПродолжитьОбработчик(ПараметрыОбновления);
	
	МассивРегистраторов = Новый Массив;
	
	Пока Выборка.СледующийПоЗначениюПоля("ДатаНачала") Цикл
		
		Пока Выборка.СледующийПоЗначениюПоля("Регистратор") Цикл
			
			Если ЗначениеЗаполнено(Выборка.РегистраторИзмерение) Тогда
				
				Если Не ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПодготовитьОбновлениеДанных(ПараметрыОбновления, "РегистрСведений.ЗанятостьПозицийШтатногоРасписанияИспр", "РегистраторИзмерение", Выборка.РегистраторИзмерение) Тогда
					Продолжить;
				КонецЕсли;
				
			Иначе
				
				МассивРегистраторов.Добавить(Выборка.Регистратор);
				
				Если Не ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПодготовитьОбновлениеДанных(ПараметрыОбновления, "РегистрСведений.ЗанятостьПозицийШтатногоРасписания.НаборЗаписей", "Регистратор", Выборка.Регистратор) Тогда
					Продолжить;
				КонецЕсли;
				
			КонецЕсли;
			
			ДанныеВыборки = Новый Структура("Регистратор,ДатаНачала,ДатаОкончания,РегистраторИзмерение");
			ЗаполнитьЗначенияСвойств(ДанныеВыборки, Выборка);
			
			Сотрудники = Новый Массив;
			Пока Выборка.Следующий() Цикл
				Сотрудники.Добавить(Выборка.Сотрудник);
			КонецЦикла;
			
			ДокументОбъект = ДанныеВыборки.Регистратор.ПолучитьОбъект();
			
			ЗарплатаКадрыРасширенный.УстановитьВремяРегистрацииДокумента(
				ДокументОбъект.Движения,
				КадровыйУчетРасширенный.ТаблицаСотрудникиДатыСобытия(Сотрудники, ДанныеВыборки.ДатаНачала),
				ДанныеВыборки.Регистратор);
			
			СформироватьДвиженияЗанятостиВременноОсвобожденныхПозицииПоТаблицеЗначений(
				ДокументОбъект.Движения,
				КадровыйУчетРасширенный.ТаблицаЗначенийСотрудникиПериоды(Сотрудники, ДанныеВыборки.ДатаНачала, ДанныеВыборки.ДатаОкончания),
				ДатаОкончанияПланируемая);
			
			ЗарплатаКадрыРасширенныйСобытия.УстановитьСдвигПериодаРегистраСПериодичностьюСекунда(
				ДокументОбъект.Движения.ЗанятостьПозицийШтатногоРасписания, Ложь, Истина);
			
			Если ЗначениеЗаполнено(ДанныеВыборки.РегистраторИзмерение) Тогда
				
				НаборЗаписей = РегистрыСведений.ЗанятостьПозицийШтатногоРасписанияИспр.СоздатьНаборЗаписей();
				НаборЗаписей.Отбор.РегистраторИзмерение.Установить(ДанныеВыборки.РегистраторИзмерение);
				
				Для Каждого Запись Из ДокументОбъект.Движения.ЗанятостьПозицийШтатногоРасписания Цикл
					
					НоваяЗапись = НаборЗаписей.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяЗапись, Запись);
					
					НоваяЗапись.ПериодИзмерение = Запись.Период;
					НоваяЗапись.РегистраторИзмерение = ДанныеВыборки.РегистраторИзмерение;
					
				КонецЦикла;
				
			Иначе
				НаборЗаписей = ДокументОбъект.Движения.ЗанятостьПозицийШтатногоРасписания;
			КонецЕсли;
			
			НаборЗаписей.ДополнительныеСвойства.Вставить("ОтключитьПроверкуДатыЗапретаИзменения", Истина);
			
			ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
			ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбновлениеДанных(ПараметрыОбновления);
			
		КонецЦикла;
		
	КонецЦикла;
	
	РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.СформироватьДвиженияИнтервальногоРегистраПоМассивуРегистраторов(
		МассивРегистраторов, ПараметрыОбновления);
	
КонецПроцедуры

Процедура СформироватьДвиженияЗанятостиВременноОсвобожденныхПозицииПоТаблицеЗначений(Движения, СотрудникиПериоды, ДатаОкончанияПланируемая) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ПараметрыПостроения = КадровыйУчетРасширенный.ПараметрыПостроенияСрезовЗанятостиПозицийШтатногоРасписания(Движения);
	
	ОписаниеФильтра = ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра(СотрудникиПериоды, "Сотрудник");
	ОписаниеФильтра.СоответствиеИзмеренийРегистраИзмерениямФильтра.Вставить("Период","ДатаНачала");
	
	ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистраСрезПоследних(
		"КадроваяИсторияСотрудников",
		Запрос.МенеджерВременныхТаблиц,
		Ложь,
		ОписаниеФильтра,
		ПараметрыПостроения);
	
	ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистраСрезПоследних(
		"ЗанятостьПозицийШтатногоРасписания",
		Запрос.МенеджерВременныхТаблиц,
		Ложь,
		ОписаниеФильтра,
		ПараметрыПостроения);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	КадроваяИсторияСотрудников.Период КАК Период,
		|	КадроваяИсторияСотрудников.Сотрудник КАК Сотрудник,
		|	КадроваяИсторияСотрудников.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
		|	КадроваяИсторияСотрудников.ФизическоеЛицо КАК ФизическоеЛицо,
		|	НЕОПРЕДЕЛЕНО КАК ДокументОснование,
		|	КадроваяИсторияСотрудников.ДолжностьПоШтатномуРасписанию КАК ПозицияШтатногоРасписания,
		|	ЗНАЧЕНИЕ(Перечисление.ВидыЗанятостиПозицийШтатногоРасписания.Свободна) КАК ВидЗанятостиПозиции,
		|	КадроваяИсторияСотрудников.КоличествоСтавок КАК КоличествоСтавок,
		|	ДАТАВРЕМЯ(1, 1, 1) КАК ПланируемаяДатаЗавершения,
		|	ДАТАВРЕМЯ(1, 1, 1) КАК ДействуетДо,
		|	КадроваяИсторияСотрудников.Сотрудник КАК ЗамещаемыйСотрудник
		|ИЗ
		|	ВТКадроваяИсторияСотрудниковСрезПоследних КАК КадроваяИсторияСотрудников
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЗанятостьПозицийШтатногоРасписания.Период,
		|	ЗанятостьПозицийШтатногоРасписания.Сотрудник,
		|	ЗанятостьПозицийШтатногоРасписания.ГоловнаяОрганизация,
		|	ЗанятостьПозицийШтатногоРасписания.ФизическоеЛицо,
		|	ЗанятостьПозицийШтатногоРасписания.ДокументОснование,
		|	ЗанятостьПозицийШтатногоРасписания.ПозицияШтатногоРасписания,
		|	ЗНАЧЕНИЕ(Перечисление.ВидыЗанятостиПозицийШтатногоРасписания.Свободна),
		|	ЗанятостьПозицийШтатногоРасписания.КоличествоСтавок,
		|	ДАТАВРЕМЯ(1, 1, 1),
		|	ДАТАВРЕМЯ(1, 1, 1),
		|	ЗанятостьПозицийШтатногоРасписания.Сотрудник
		|ИЗ
		|	ВТЗанятостьПозицийШтатногоРасписанияСрезПоследних КАК ЗанятостьПозицийШтатногоРасписания
		|ГДЕ
		|	ЗанятостьПозицийШтатногоРасписания.ВидЗанятостиПозиции = ЗНАЧЕНИЕ(Перечисление.ВидыЗанятостиПозицийШтатногоРасписания.Совмещена)
		|	И ЗанятостьПозицийШтатногоРасписания.КоличествоСтавок > 0";
	
	ЗанятостьПозицийШтатногоРасписания = Запрос.Выполнить().Выгрузить();
	
	Если СотрудникиПериоды.Количество() <> СотрудникиПериоды.НайтиСтроки(Новый Структура("ДатаОкончания", '00010101')).Количество() Тогда
		
		Для Каждого ЗаписьЗанятостиПозиций Из ЗанятостьПозицийШтатногоРасписания Цикл
			
			СтрокиСотрудника = СотрудникиПериоды.НайтиСтроки(Новый Структура("ДатаНачала,Сотрудник", ЗаписьЗанятостиПозиций.Период, ЗаписьЗанятостиПозиций.Сотрудник));
			Если СтрокиСотрудника.Количество() > 0 Тогда
				
				СтрокаСотрудника = СтрокиСотрудника[0];
				Если ЗначениеЗаполнено(СтрокаСотрудника.ДатаОкончания) Тогда
					
					Если ДатаОкончанияПланируемая Тогда
						ЗаписьЗанятостиПозиций.ПланируемаяДатаЗавершения = СтрокаСотрудника.ДатаОкончания;
					Иначе
						ЗаписьЗанятостиПозиций.ДействуетДо = КонецДня(СтрокаСотрудника.ДатаОкончания) + 1;
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	КадровыйУчетРасширенный.СформироватьДвиженияЗанятостьПозицийШтатногоРасписания(Движения, ЗанятостьПозицийШтатногоРасписания);
	
КонецПроцедуры

Процедура ПодготовитьОбновлениеЗависимыхДанныхПриОбменеПередЗаписью(Объект) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПередЗаписью(Объект);
	
КонецПроцедуры

Процедура ПодготовитьОбновлениеЗависимыхДанныхПриОбменеПриЗаписи(Объект) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПриЗаписи(Объект);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
