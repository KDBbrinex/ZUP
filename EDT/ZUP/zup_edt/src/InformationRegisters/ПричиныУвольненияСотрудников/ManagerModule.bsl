#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОрганизацииВКоторыхРаботалиСотрудники КАК Т2 
	|	ПО Т2.Сотрудник = Т.Сотрудник
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т2.Организация)
	|	и ЗначениеРазрешено(Т.ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПредставлениеПричинСотрудника(СотрудникСсылка, ПричиныВведены = Ложь, ТолькоПричинаHR = Истина) Экспорт 
	
	Если Не ЗначениеЗаполнено(СотрудникСсылка) Тогда
		Возврат "";
	КонецЕсли;	
	
	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПричиныУвольненияСотрудников) Тогда
		Возврат "";
	КонецЕсли;	
		
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Сотрудник", СотрудникСсылка);
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	ПричиныУвольненияСотрудников.ПричинаHR КАК ПричинаHR,
		|	ПричиныУвольненияСотрудников.ПричинаРуководитель КАК ПричинаРуководитель,
		|	ПричиныУвольненияСотрудников.ДатаРегистрации КАК ДатаРегистрации,
		|	ПричиныУвольненияСотрудников.Ответственный КАК Ответственный
		|ИЗ
		|	РегистрСведений.ПричиныУвольненияСотрудников КАК ПричиныУвольненияСотрудников
		|ГДЕ
		|	ПричиныУвольненияСотрудников.Сотрудник = &Сотрудник";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат НСтр("ru = 'Выберите обстоятельства увольнения...'");
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Если ТолькоПричинаHR Тогда
		Возврат Строка(Выборка.ПричинаHR);
	КонецЕсли;
	
	ПричинаHR = Выборка.ПричинаHR;
	Если Не ЗначениеЗаполнено(ПричинаHR) Тогда
		ПричинаHR = НСтр("ru = '<Причина не указана>'");
	КонецЕсли;
	
	ПричинаРуководитель = Выборка.ПричинаРуководитель;
	Если Не ЗначениеЗаполнено(ПричинаРуководитель) Тогда
		ПричинаРуководитель = НСтр("ru = '<Причина не указана>'");
	КонецЕсли;
	
	ШаблонПредставления = НСтр("ru = '%1 (HR)
                                |%2 (руководитель)
                                |Заполнено %3 пользователем %4'");
	
	Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ШаблонПредставления, ПричинаHR, ПричинаРуководитель, Формат(Выборка.ДатаРегистрации, "ДЛФ=D"), Выборка.Ответственный);

КонецФункции

Функция МожноРегистрироватьПричиныУвольнения(Сотрудник) Экспорт 

	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПричиныУвольненияСотрудников) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Сотрудники = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Сотрудник);
	КадровыеДанные = КадровыйУчет.КадровыеДанныеСотрудников(Истина, Сотрудники, "ВидЗанятости");
	
	Если КадровыеДанные.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ВидыЗанятости = Новый Массив;
	ВидыЗанятости.Добавить(Перечисления.ВидыЗанятости.ОсновноеМестоРаботы);
	ВидыЗанятости.Добавить(Перечисления.ВидыЗанятости.Совместительство);
	
	Если ВидыЗанятости.Найти(КадровыеДанные[0].ВидЗанятости) = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;

КонецФункции

#КонецОбласти

#КонецЕсли


