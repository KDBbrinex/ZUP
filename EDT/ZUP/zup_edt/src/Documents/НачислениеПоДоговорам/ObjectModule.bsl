#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли; 
			
	Документы.НачислениеПоДоговорам.ЗаполнитьПредставлениеРаспределенияРезультатовРасчета(ЭтотОбъект);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Для каждого СтрокаНачислений Из НачисленияПоДоговорам Цикл
		
		ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, СтрокаНачислений.ПланируемаяДатаВыплаты, "Объект.НачисленияПоДоговорам[" + Формат(СтрокаНачислений.НомерСтроки - 1, "ЧГ=") + "].ПланируемаяДатаВыплаты",
			Отказ, НСтр("ru='Дата выплаты'"), Дата, НСтр("ru='даты документа'"));
		
	КонецЦикла;
	
	ПроверитьПериодДействияУдержаний(Отказ);
	
	ПроверитьНачисленияПоДоговорам(Отказ);
	
	ПроверитьРаспределениеПоИсточникамФинансирования(Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Документы.НачислениеПоДоговорам.ПровестиПоУчетам(Ссылка, РежимПроведения, Отказ, Неопределено, Движения, ЭтотОбъект, ДополнительныеСвойства);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Вспомогательные процедуры и функции.

Процедура ПроверитьПериодДействияУдержаний(Отказ)
	
	ПараметрыПроверки = РасчетЗарплатыРасширенный.ПараметрыПроверкиПериодаДействия();
	ПараметрыПроверки.Ссылка = Ссылка;
	
	ПроверяемыеКоллекции = Новый Массив;
	ПроверяемыеКоллекции.Добавить(РасчетЗарплатыРасширенный.ОписаниеКоллекцииДляПроверкиПериодаДействия("Удержания", НСтр("ru = 'Удержания'"), "Удержание"));
	
	РасчетЗарплатыРасширенный.ПроверитьПериодДействияВКоллекцияхНачислений(ЭтотОбъект, ПараметрыПроверки, ПроверяемыеКоллекции, Отказ);
	
КонецПроцедуры

Процедура ПроверитьНачисленияПоДоговорам(Отказ)
			
	Для Каждого СтрокаПоДоговору Из НачисленияПоДоговорам Цикл
		Если Не ЗначениеЗаполнено(СтрокаПоДоговору.ДокументОснование) Тогда
			Продолжить;
		КонецЕсли;
		СотрудникДоговора = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаПоДоговору.ДокументОснование, "Сотрудник");
		Если СтрокаПоДоговору.Сотрудник <> СотрудникДоговора Тогда
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='В строке %1, табличной части ""Начисления по договорам"" для сотрудника %2 указан договор другого сотрудника (%3)'"),
				СтрокаПоДоговору.НомерСтроки,
				СтрокаПоДоговору.Сотрудник,
				СотрудникДоговора);
			ОбщегоНазначения.СообщитьПользователю(
				ТекстСообщения, , "Объект.НачисленияПоДоговорам[" + Формат(СтрокаПоДоговору.НомерСтроки - 1, "ЧН=; ЧГ=") + "].ДокументОснование" , , Отказ);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьРаспределениеПоИсточникамФинансирования(Отказ)
	
	ИменаТаблицРаспределяемыхПоСтатьямФинансирования =
		"НачисленияПоДоговорам,Удержания,НДФЛ,КорректировкиВыплаты";
	
	ОтражениеЗарплатыВБухучетеРасширенный.ПроверитьРезультатыРаспределенияНачисленийУдержанийОбъекта(
		ЭтотОбъект, ИменаТаблицРаспределяемыхПоСтатьямФинансирования, Отказ);
			
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли