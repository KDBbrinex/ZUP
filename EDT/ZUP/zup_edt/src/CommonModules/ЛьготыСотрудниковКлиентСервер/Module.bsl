
#Область СлужебныеПроцедурыИФункции

Процедура ДополнитьМассивОписанийТаблицФормыНачисленияЗарплаты(МассивОписанийТаблиц, ОписанияТаблиц) Экспорт 
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпцию("ИспользоватьЛьготыСотрудников");
	#Иначе
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпциюИнтерфейса("ИспользоватьЛьготыСотрудников");
	#КонецЕсли
	
	Если Не ФОИспользоватьЛьготыСотрудников Тогда 
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ОписанияТаблиц) = Тип("Массив") Тогда
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивОписанийТаблиц, ОписанияТаблиц);
	Иначе
		МассивОписанийТаблиц.Добавить(ОписанияТаблиц);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДополнитьОписаниеДокументаНачислениеЗарплаты(Описание, ЛьготыИмя = "Льготы") Экспорт 
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпцию("ИспользоватьЛьготыСотрудников");
	#Иначе
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпциюИнтерфейса("ИспользоватьЛьготыСотрудников");
	#КонецЕсли
	
	Если ФОИспользоватьЛьготыСотрудников Тогда 
		Описание.ЛьготыИмя = ЛьготыИмя;
		Описание.ЛьготыКоманднаяПанельИмя = ЛьготыИмя + "АвтоКоманды";
	КонецЕсли;
	
КонецПроцедуры

Процедура ДополнитьСтруктуруОписанийТаблицФормыНачисленияЗарплаты(СтруктураОписанийТаблиц, ОписаниеТаблицыЛьгот) Экспорт 
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпцию("ИспользоватьЛьготыСотрудников");
	#Иначе
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпциюИнтерфейса("ИспользоватьЛьготыСотрудников");
	#КонецЕсли
	
	Если ФОИспользоватьЛьготыСотрудников Тогда 
		СтруктураОписанийТаблиц.Вставить(ОписаниеТаблицыЛьгот.ИмяТаблицы, ОписаниеТаблицыЛьгот);
	КонецЕсли;

КонецПроцедуры

Функция ИмяТаблицыДляРаспределенияРезультата(ИмяТаблицы) Экспорт
	
	ИмяТаблицыДляРаспределения = "";
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпцию("ИспользоватьЛьготыСотрудников");
	#Иначе
		ФОИспользоватьЛьготыСотрудников = ПолучитьФункциональнуюОпциюИнтерфейса("ИспользоватьЛьготыСотрудников");
	#КонецЕсли
	
	Если ФОИспользоватьЛьготыСотрудников Тогда
		
		Если ИмяТаблицы = "Льготы" Тогда
			ИмяТаблицыДляРаспределения = "РаспределениеРезультатовНачислений";
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ИмяТаблицыДляРаспределения;
	
КонецФункции

#КонецОбласти
