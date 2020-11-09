#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		ЗарплатаКадры.ЗаполнитьПоОснованиюСотрудником(ЭтотОбъект, ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаВрученияСотруднику, "Объект.ДатаВрученияСотруднику", Отказ, НСтр("ru='Дата выдачи'"), , , Ложь);
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаРождения, "Объект.ДатаРождения", Отказ, НСтр("ru='Дата рождения'"), '19000101', , Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОбновитьВторичныеДанныеДокумента(ДанныеОрганизации = Истина, ДанныеСотрудника = Истина) Экспорт 
	Модифицирован = Ложь;
	
	Если ОбъектЗафиксирован() Тогда
		Возврат Модифицирован;
	КонецЕсли;
	
	ПараметрыФиксации = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(Метаданные().ПолноеИмя()).ПараметрыФиксацииВторичныхДанных();
	
	Если ДанныеОрганизации И ЗаполнитьДанныеОрганизации(ПараметрыФиксации) Тогда
		Модифицирован = Истина;
	КонецЕсли;
	
	Если ДанныеСотрудника И ЗаполнитьДанныеСотрудника(ПараметрыФиксации) Тогда
		Модифицирован = Истина;
	КонецЕсли;
	
	Возврат Модифицирован;
КонецФункции

Функция ЗаполнитьДанныеСотрудника(ПараметрыФиксации)
	Если Не ЗначениеЗаполнено(Сотрудник) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	КадровыеДанные = "Подразделение, Должность, ФизическоеЛицо, ДатаРождения, Образование1ВидОбразования, СемейноеПоложение, ВоинскийУчетЗвание, ВоинскийУчетВУС, СоставСемьи, АдресМестаПроживанияПредставление";
	ДанныеСотрудника = КадровыйУчет.КадровыеДанныеСотрудников(Истина, Сотрудник, КадровыеДанные, Дата);
	
	РеквизитыДокумента = Новый Структура("Подразделение, Должность, ДатаРождения, Образование, СемейноеПоложение, Звание, ВУС, СоставСемьи, АдресМестаПроживанияПредставление");
	
	Если ДанныеСотрудника.Количество() > 0 Тогда
		ЗаполнитьЗначенияСвойств(РеквизитыДокумента, ДанныеСотрудника[0]);
		РеквизитыДокумента.Образование = ДанныеСотрудника[0].Образование1ВидОбразования;
		РеквизитыДокумента.Звание      = ДанныеСотрудника[0].ВоинскийУчетЗвание;
		РеквизитыДокумента.ВУС         = ДанныеСотрудника[0].ВоинскийУчетВУС;
		
		СведенияОСемье = Документы.ЛистокСообщенияДляВоенкомата.СведенияОСоставеСемьи(ДанныеСотрудника[0].ФизическоеЛицо);
		РеквизитыДокумента.СоставСемьи = СведенияОСемье.СоставСемьиКраткий;
	КонецЕсли;
	
	Возврат ФиксацияВторичныхДанныхВДокументах.ОбновитьДанныеШапки(РеквизитыДокумента, ЭтотОбъект, ПараметрыФиксации);
КонецФункции

Функция ЗаполнитьДанныеОрганизации(ПараметрыФиксации)
	ОтветственныеЛица = Новый Структура("Организация,ОтветственныйЗаВУР", Организация);
	ЗарплатаКадры.ПолучитьЗначенияПоУмолчанию(ОтветственныеЛица, Дата);
	
	РеквизитыДокумента = Новый Структура("ОтветственныйЗаВУР", ОтветственныеЛица.ОтветственныйЗаВУР);
	
	Возврат ФиксацияВторичныхДанныхВДокументах.ОбновитьДанныеШапки(РеквизитыДокумента, ЭтотОбъект, ПараметрыФиксации);
КонецФункции

Функция ОбъектЗафиксирован() Экспорт
	
	Возврат Проведен;
	
КонецФункции 

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли