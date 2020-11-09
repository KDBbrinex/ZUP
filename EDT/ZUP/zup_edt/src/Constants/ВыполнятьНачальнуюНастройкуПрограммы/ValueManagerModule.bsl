#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	НачальнаяНастройкаПрограммыЗавершена = Не Значение;
	Если НачальнаяНастройкаПрограммыЗавершена <> Константы.НеВыполнятьНачальнуюНастройкуПрограммы.Получить() Тогда
		Константы.НеВыполнятьНачальнуюНастройкуПрограммы.Установить(НачальнаяНастройкаПрограммыЗавершена);
	КонецЕсли;
	Если Не ОбщегоНазначения.РазделениеВключено()
		И Не ОбщегоНазначения.ЭтоАвтономноеРабочееМесто()
		И ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		Если НачальнаяНастройкаПрограммыЗавершена <> Константы["РазрешенаРаботаСНовостями"].Получить() Тогда
			Константы["РазрешенаРаботаСНовостями"].Установить(НачальнаяНастройкаПрограммыЗавершена);
		КонецЕсли;
	КонецЕсли;
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	КабинетСотрудника.УстановитьЗначениеПоказыватьПриглашениеКабинетСотрудника(, Значение);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли