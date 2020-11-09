#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ИспользоватьЭлектронныйДокументооборотСБанком Тогда
		
		Если ОбменСБанкамиПоЗарплатнымПроектам.ИспользоватьТиповойЭОИСБанком(Ссылка) Тогда
			МаксимальнаяДлинаНомераДоговора = 
				ОбменСБанкамиПоЗарплатнымПроектамКлиентСервер.МаксимальнаяДлинаНомераДоговора(ФорматФайла);
			Если СтрДлина(СокрЛП(НомерДоговора)) > МаксимальнаяДлинаНомераДоговора Тогда
				ТекстОшибки = 
					СтрШаблон(
						НСтр("ru = 'При использовании типового обмена длина номера договора поддерживается до %1 символов.'"),
						МаксимальнаяДлинаНомераДоговора);
				ОбщегоНазначения.СообщитьПользователю(ТекстОшибки,, "Объект.НомерДоговора",, Отказ);
			КонецЕсли;
		КонецЕсли;
		
	Иначе	
		
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Банк");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "НомерДоговора");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СистемыРасчетовПоБанковскимКартам");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СистемыРасчетовПоБанковскимКартам.СистемаРасчетовПоБанковскимКартам");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "КодировкаФайла");
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	НомерДоговора = СокрЛП(НомерДоговора)
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли