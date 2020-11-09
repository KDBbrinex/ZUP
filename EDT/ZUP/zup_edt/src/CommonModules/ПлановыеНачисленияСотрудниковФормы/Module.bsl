#Область СлужебныйПрограммныйИнтерфейс

Процедура РассчитатьЗначениеПоказателяНачисления(ИсходноеЗначение, СтруктураДействие, Показатель) Экспорт
	
	Действие = СтруктураДействие.Действие;
	ЗначениеДействия = СтруктураДействие.Значение;
	Если Действие = "ФиксЗначение" Тогда
		ИсходноеЗначение = ЗначениеДействия;
	ИначеЕсли Действие = "Прибавить" Тогда
		ИсходноеЗначение = ИсходноеЗначение + ЗначениеДействия;
	ИначеЕсли Действие = "Умножить" Тогда
		ИсходноеЗначение = ИсходноеЗначение * ЗначениеДействия;
	КонецЕсли;
	
	Если СтруктураДействие.Свойство("Округление") Тогда
		Если ТипЗнч(Показатель) = Тип("СправочникСсылка.ПоказателиРасчетаЗарплаты") Тогда
			Точность = ЗарплатаКадрыРасширенныйПовтИсп.СведенияОПоказателеРасчетаЗарплаты(Показатель).Точность;
			Точность = Pow(0.1, Точность);
		Иначе
			Точность = 0.01;
		КонецЕсли;
		ОписаниеОкругления = ЗарплатаКадрыРасширенныйПовтИсп.ОписаниеСпособаОкругления(СтруктураДействие.Округление);
		Точность = Макс(Точность, ОписаниеОкругления.Точность);
		ИсходноеЗначение = ЗарплатаКадрыКлиентСервер.Округлить(ИсходноеЗначение, Точность, ОписаниеОкругления.ПравилоОкругления);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьДанныеПлановыхНачисленийПоСотруднику(ТаблицаНачислений, ТаблицаПоказателей, Форма, Сотрудник, ГоловнаяОрганизация, ДатаСобытия, ОписаниеТаблицыВидовРасчета) Экспорт			
	ДанныеНачислений = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицыВидовРасчета.ПутьКДанным);
	Для Каждого СтрокаНачисления Из ДанныеНачислений Цикл
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.ТабличнаяЧастьСодержитПолеДействие(ОписаниеТаблицыВидовРасчета) Тогда
			
			Если СтрокаНачисления.Действие = Перечисления.ДействияСНачислениямиИУдержаниями.Отменить Тогда
				Продолжить;
			КонецЕсли;
			
			Если СтрокаНачисления.Действие = Перечисления.ДействияСНачислениямиИУдержаниями.ПустаяСсылка()
				И СтрокаНачисления.Свойство("ДействующийВидРасчета")
				И Не СтрокаНачисления.ДействующийВидРасчета Тогда
				
				Продолжить;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если СтрокаНачисления.Свойство("ДатаНачала")
			И ЗначениеЗаполнено(СтрокаНачисления.ДатаНачала)
			И СтрокаНачисления.ДатаНачала <> НачалоДня(ДатаСобытия) Тогда
			
			Продолжить;
			
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(СтрокаНачисления[ОписаниеТаблицыВидовРасчета.ИмяРеквизитаВидРасчета]) Тогда
			Продолжить;
		КонецЕсли;
		
		ИнфоОВидеРасчета = ЗарплатаКадрыРасширенныйПовтИсп.ПолучитьИнформациюОВидеРасчета(СтрокаНачисления[ОписаниеТаблицыВидовРасчета.ИмяРеквизитаВидРасчета]);
		
		Если ИнфоОВидеРасчета.ЯвляетсяЛьготой И Не ИнфоОВидеРасчета.ЛьготаУчитываетсяПриРасчетеЗарплаты Тогда 
			Продолжить;
		КонецЕсли;
				
		Если ИнфоОВидеРасчета.Рассчитывается Тогда
			Размер = СтрокаНачисления.Размер;
		Иначе
			Размер = СтрокаНачисления.Значение1;
		КонецЕсли;
		
		ДокументОснование = Неопределено;
		Если ЗначениеЗаполнено(ОписаниеТаблицыВидовРасчета.ИмяРеквизитаДокументОснование) Тогда 
			ДокументОснование = СтрокаНачисления[ОписаниеТаблицыВидовРасчета.ИмяРеквизитаДокументОснование];
		КонецЕсли;
		
		ДанныеНачисления = ТаблицаНачислений.Добавить();
		ДанныеНачисления.Сотрудник = Сотрудник;
		ДанныеНачисления.Период = ДатаСобытия;
		ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;
				
		ДанныеНачисления.Начисление = СтрокаНачисления[ОписаниеТаблицыВидовРасчета.ИмяРеквизитаВидРасчета];
		ДанныеНачисления.ДокументОснование = ДокументОснование;
		ДанныеНачисления.Размер = Размер;
		
		Для НомерПоказателя = 1 По ЗарплатаКадрыРасширенныйКлиентСервер.МаксимальноеКоличествоПоказателейПоОписаниюТаблицы(Форма, ОписаниеТаблицыВидовРасчета) Цикл
			
			Если НЕ ЗначениеЗаполнено(СтрокаНачисления["Показатель" + НомерПоказателя]) Тогда
				Прервать;
			КонецЕсли;
			
			ДанныеПоказателя = ТаблицаПоказателей.Добавить();
			ДанныеПоказателя.Сотрудник = Сотрудник;
			ДанныеПоказателя.Период = ДатаСобытия;
			ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;
	
			ДанныеПоказателя.Показатель = СтрокаНачисления["Показатель" + НомерПоказателя];
			ДанныеПоказателя.ДокументОснование = ДокументОснование;
			ДанныеПоказателя.Значение = СтрокаНачисления["Значение" + НомерПоказателя];
			
		КонецЦикла;
		
	КонецЦикла;
		
	Если ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоТарифныхСтавок") 
		И ЗначениеЗаполнено(ОписаниеТаблицыВидовРасчета.ПутьКДаннымПоказателей) Тогда
		
		ДанныеПоказателей = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицыВидовРасчета.ПутьКДаннымПоказателей);
		СтрокиДополнительныхПоказателей = ДанныеПоказателей.НайтиСтроки(Новый Структура(ОписаниеТаблицыВидовРасчета.ИмяРеквизитаИдентификаторСтроки, 0));
		
		Для Каждого СтрокаСДополнительнымПоказателем Из СтрокиДополнительныхПоказателей Цикл
			ДанныеПоказателя = ТаблицаПоказателей.Добавить();
			ДанныеПоказателя.Сотрудник = Сотрудник;
			ДанныеПоказателя.Период = ДатаСобытия;
			ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;

			ДанныеПоказателя.Показатель = СтрокаСДополнительнымПоказателем.Показатель;
			ДанныеПоказателя.ДокументОснование = Неопределено;
			ДанныеПоказателя.Значение = СтрокаСДополнительнымПоказателем.Значение;
		КонецЦикла;
		
	КонецЕсли;
	
	Если ЗарплатаКадрыРасширенныйКлиентСервер.РедактироватьНачисленияВОтдельныхПолях(1, ОписаниеТаблицыВидовРасчета) Тогда
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.НадбавкаЗаВредностьПрименяется(Форма) Тогда
			
			ДанныеНачисления = ТаблицаНачислений.Добавить();
			ДанныеНачисления.Сотрудник = Сотрудник;
			ДанныеНачисления.Период = ДатаСобытия;
			ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;
			ДанныеНачисления.НеобходимПерерасчетФОТ = Истина;

			ДанныеНачисления.Начисление = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеНадбавкаЗаВредность");
			ДанныеНачисления.ДокументОснование = Неопределено;
			ДанныеНачисления.Размер = 0;
			
			ДанныеПоказателя = ТаблицаПоказателей.Добавить();
			ДанныеПоказателя.Сотрудник = Сотрудник;
			ДанныеПоказателя.Период = ДатаСобытия;
			ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;

			ДанныеПоказателя.Показатель = ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ПроцентНадбавкиЗаВредность");
			ДанныеПоказателя.ДокументОснование = Неопределено;
			ДанныеПоказателя.Значение = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "ЗначениеПоказателяНадбавкаЗаВредность");
			
		КонецЕсли;
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.РайонныйКоэффициентПрименяется(Форма) Тогда
			
			ДанныеНачисления = ТаблицаНачислений.Добавить();
			ДанныеНачисления.Сотрудник = Сотрудник;
			ДанныеНачисления.Период = ДатаСобытия;
			ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;
			ДанныеНачисления.НеобходимПерерасчетФОТ = Истина;

			ДанныеНачисления.Начисление = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеРайонныйКоэффициент");
			ДанныеНачисления.ДокументОснование = Неопределено;
			ДанныеНачисления.Размер = 0;
			
			ДанныеПоказателя = ТаблицаПоказателей.Добавить();
			ДанныеПоказателя.Сотрудник = Сотрудник;
			ДанныеПоказателя.Период = ДатаСобытия;
			ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;

			ДанныеПоказателя.Показатель = ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.РайонныйКоэффициент");
			ДанныеПоказателя.ДокументОснование = Неопределено;
			ДанныеПоказателя.Значение = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "ЗначениеПоказателяРайонныйКоэффициент");
			
		КонецЕсли;
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.СевернаяНадбавкаПрименяется(Форма) Тогда
			
			ДанныеНачисления = ТаблицаНачислений.Добавить();
			ДанныеНачисления.Сотрудник = Сотрудник;
			ДанныеНачисления.Период = ДатаСобытия;
			ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;
			ДанныеНачисления.НеобходимПерерасчетФОТ = Истина;

			ДанныеНачисления.Начисление = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеСевернаяНадбавка");
			ДанныеНачисления.ДокументОснование = Неопределено;
			ДанныеНачисления.Размер = 0;
			
			ДанныеПоказателя = ТаблицаПоказателей.Добавить();
			ДанныеПоказателя.Сотрудник = Сотрудник;
			ДанныеПоказателя.Период = ДатаСобытия;
			ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;

			ДанныеПоказателя.Показатель = ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СевернаяНадбавка");
			ДанныеПоказателя.ДокументОснование = Неопределено;
			ДанныеПоказателя.Значение = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "ЗначениеПоказателяСевернаяНадбавка");
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ОписаниеДанныхТарифныхСтавок(ВидТарифнойСтавкиПутьКДанным, СовокупнаяТарифнаяСтавкаПутьКДанным) Экспорт
	ОписаниеДанныхТарифныхСтавок = Новый Структура;	
	ОписаниеДанныхТарифныхСтавок.Вставить("ВидТарифнойСтавкиПутьКДанным", ВидТарифнойСтавкиПутьКДанным);
	ОписаниеДанныхТарифныхСтавок.Вставить("СовокупнаяТарифнаяСтавкаПутьКДанным", СовокупнаяТарифнаяСтавкаПутьКДанным);
	
	Возврат ОписаниеДанныхТарифныхСтавок;
КонецФункции	

Процедура РезультатРасчетаВторичныхДанныхПоСотрудникуВДанныеФормы(Форма, РезультатРасчета, ГоловнаяОрганизация, ОписаниеТаблицаНачислений, ОписаниеДанныхТарифныхСтавок = Неопределено) Экспорт
	ДанныеНачислений = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицаНачислений.ПутьКДанным);	
	
	РассчитанныеДанныеФОТ = РезультатРасчета.ПлановыйФОТ;
	РассчитанныеТарифныеСтавки = РезультатРасчета.ТарифныеСтавки;
	
	РассчитанныеДанныеФОТ.Индексы.Добавить("Начисление, ДокументОснование, ГоловнаяОрганизация");
	РассчитанныеДанныеФОТ.Индексы.Добавить("Начисление, ГоловнаяОрганизация");
	СтруктураПоиска = Новый Структура("Начисление, ДокументОснование, ГоловнаяОрганизация");
	
	СтруктураПоиска.ГоловнаяОрганизация = ГоловнаяОрганизация;
	
	Для Каждого СтрокаТаблицыФормы Из ДанныеНачислений Цикл
		ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтрокаТаблицыФормы);
		
		НайденныеСтроки = РассчитанныеДанныеФОТ.НайтиСтроки(СтруктураПоиска);
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			СтрокаТаблицыФормы.Размер = НайденныеСтроки[0].ВкладВФОТ;	
		КонецЕсли;
	КонецЦикла;	
	
	СтруктураПоиска.Удалить("ДокументОснование");
		
	Если ЗарплатаКадрыРасширенныйКлиентСервер.РедактироватьНачисленияВОтдельныхПолях(1, ОписаниеТаблицаНачислений) Тогда	
		Если ЗарплатаКадрыРасширенныйКлиентСервер.НадбавкаЗаВредностьПрименяется(Форма) Тогда			
			СтруктураПоиска.Начисление =  ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеНадбавкаЗаВредность");
			НайденныеСтроки = РассчитанныеДанныеФОТ.НайтиСтроки(СтруктураПоиска);
		
			Если НайденныеСтроки.Количество() > 0 Тогда
				Размер = НайденныеСтроки[0].ВкладВФОТ;
			Иначе
				Размер = 0;	
			КонецЕсли;

			ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "РазмерНадбавкаЗаВредность", Размер);			
		КонецЕсли;
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.РайонныйКоэффициентПрименяется(Форма) Тогда			
			СтруктураПоиска.Начисление = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеРайонныйКоэффициент");
			НайденныеСтроки = РассчитанныеДанныеФОТ.НайтиСтроки(СтруктураПоиска);
		
			Если НайденныеСтроки.Количество() > 0 Тогда
				Размер = НайденныеСтроки[0].ВкладВФОТ;
			Иначе
				Размер = 0;	
			КонецЕсли;

			ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "РазмерРайонныйКоэффициент", Размер);			
		КонецЕсли;
		
		Если ЗарплатаКадрыРасширенныйКлиентСервер.СевернаяНадбавкаПрименяется(Форма) Тогда
			СтруктураПоиска.Начисление = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "НачислениеСевернаяНадбавка");
			НайденныеСтроки = РассчитанныеДанныеФОТ.НайтиСтроки(СтруктураПоиска);
		
			Если НайденныеСтроки.Количество() > 0 Тогда
				Размер = НайденныеСтроки[0].ВкладВФОТ;
			Иначе
				Размер = 0;	
			КонецЕсли;

			ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "РазмерСевернаяНадбавка", Размер);						
		КонецЕсли;	
	КонецЕсли;
	
	Если РассчитанныеТарифныеСтавки.Количество() > 0 И 
		ОписаниеДанныхТарифныхСтавок <> Неопределено Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, ОписаниеДанныхТарифныхСтавок.ВидТарифнойСтавкиПутьКДанным, РассчитанныеТарифныеСтавки[0].ВидТарифнойСтавки); 
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, ОписаниеДанныхТарифныхСтавок.СовокупнаяТарифнаяСтавкаПутьКДанным, РассчитанныеТарифныеСтавки[0].СовокупнаяТарифнаяСтавка);
	КонецЕсли;	
КонецПроцедуры	

Функция ОписаниеТаблицыТарифныхСтавок(ПутьКДаннымТаблицы, СотрудникПутьКДанным, ВидТарифнойСтавкиПутьКДанным, СовокупнаяТарифнаяСтавкаПутьКДанным) Экспорт
	ОписаниеДанныхТарифныхСтавок = Новый Структура;	
	ОписаниеДанныхТарифныхСтавок.Вставить("ПутьКДаннымТаблицы", ПутьКДаннымТаблицы);
	ОписаниеДанныхТарифныхСтавок.Вставить("СотрудникПутьКДанным", СотрудникПутьКДанным);
	ОписаниеДанныхТарифныхСтавок.Вставить("ВидТарифнойСтавкиПутьКДанным", ВидТарифнойСтавкиПутьКДанным);
	ОписаниеДанныхТарифныхСтавок.Вставить("СовокупнаяТарифнаяСтавкаПутьКДанным", СовокупнаяТарифнаяСтавкаПутьКДанным);
	
	Возврат ОписаниеДанныхТарифныхСтавок;
КонецФункции	

Процедура ЗаполнитьДанныеПлановыхНачисленийПоСотрудникам(ТаблицаНачислений, ТаблицаПоказателей, Форма, Сотрудники, ГоловнаяОрганизация, ДатаСобытия, ОписаниеТаблицыНачислений) Экспорт
	
	ИмяРеквизитаВидРасчета = ОписаниеТаблицыНачислений.ИмяРеквизитаВидРасчета;
	
	ПутьКДанным = ОписаниеТаблицыНачислений.ПутьКДанным;
	ДанныеНачислений = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ПутьКДанным);
	
	МассивНачислений = ОбщегоНазначения.ВыгрузитьКолонку(ДанныеНачислений, ИмяРеквизитаВидРасчета, Истина);
	ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(МассивНачислений, ПланыВидовРасчета.Начисления.ПустаяСсылка());	
	
	Для Каждого Сотрудник Из Сотрудники Цикл
				
		СтрокиНачислений = ДанныеНачислений.НайтиСтроки(Новый Структура(ОписаниеТаблицыНачислений.ИмяРеквизитаСотрудник, Сотрудник));
		Для Каждого СтрокаНачисления Из СтрокиНачислений Цикл
			
			Если СтрокаНачисления.Свойство("Действие")
				И СтрокаНачисления.Действие = Перечисления.ДействияСНачислениямиИУдержаниями.Отменить Тогда
				Продолжить;
			КонецЕсли; 
			
			Если Не ЗначениеЗаполнено(СтрокаНачисления[ИмяРеквизитаВидРасчета]) Тогда
				Продолжить;
			КонецЕсли; 
			
			ИнфоОВидеРасчета = ЗарплатаКадрыРасширенныйПовтИсп.ПолучитьИнформациюОВидеРасчета(СтрокаНачисления[ИмяРеквизитаВидРасчета]);
			
			Если ИнфоОВидеРасчета.ЯвляетсяЛьготой И Не ИнфоОВидеРасчета.ЛьготаУчитываетсяПриРасчетеЗарплаты Тогда 
				Продолжить;
			КонецЕсли;
			
			Если ИнфоОВидеРасчета.Рассчитывается Тогда
				Размер = СтрокаНачисления.Размер;
			Иначе
				Размер = СтрокаНачисления.Значение1;
			КонецЕсли;
			
			ДокументОснование = Неопределено;
			Если ЗначениеЗаполнено(ОписаниеТаблицыНачислений.ИмяРеквизитаДокументОснование) Тогда 
				ДокументОснование = СтрокаНачисления[ОписаниеТаблицыНачислений.ИмяРеквизитаДокументОснование];
			КонецЕсли;
			
			ДанныеНачисления = ТаблицаНачислений.Добавить();
			ДанныеНачисления.Сотрудник = Сотрудник;
			ДанныеНачисления.Период = ДатаСобытия;
			ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;

			ДанныеНачисления.Начисление = СтрокаНачисления[ОписаниеТаблицыНачислений.ИмяРеквизитаВидРасчета];
			ДанныеНачисления.ДокументОснование = ДокументОснование;
			ДанныеНачисления.Размер = Размер;
				
			Для НомерПоказателя = 1 По ЗарплатаКадрыРасширенныйКлиентСервер.МаксимальноеКоличествоПоказателейПоОписаниюТаблицы(Форма, ОписаниеТаблицыНачислений) Цикл
				
				Если НЕ ЗначениеЗаполнено(СтрокаНачисления["Показатель" + НомерПоказателя])
					ИЛИ НЕ ЗначениеЗаполнено(СтрокаНачисления["Значение" + НомерПоказателя]) Тогда
					Прервать;
				КонецЕсли; 
				
				ДанныеПоказателя = ТаблицаПоказателей.Добавить();
				ДанныеПоказателя.Сотрудник = Сотрудник;
				ДанныеПоказателя.Период = ДатаСобытия;
				ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;
				ДанныеПоказателя.Показатель = СтрокаНачисления["Показатель" + НомерПоказателя];
				ДанныеПоказателя.ДокументОснование = ДокументОснование;
				ДанныеПоказателя.Значение = СтрокаНачисления["Значение" + НомерПоказателя];
	
			КонецЦикла;
			
		КонецЦикла;
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоТарифныхСтавок") 
			И ЗначениеЗаполнено(ОписаниеТаблицыНачислений.ПутьКДаннымПоказателей) Тогда
			
			ДанныеПоказателей = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицыНачислений.ПутьКДаннымПоказателей);
			
			СтрокиДополнительныхПоказателей = ДанныеПоказателей.НайтиСтроки(Новый Структура(
				ОписаниеТаблицыНачислений.ИмяРеквизитаСотрудник + "," + ОписаниеТаблицыНачислений.ИмяРеквизитаИдентификаторСтроки, Сотрудник, 0));
				
			Для Каждого СтрокаСДополнительнымПоказателем Из СтрокиДополнительныхПоказателей Цикл
				ДанныеПоказателя = ТаблицаПоказателей.Добавить();
				ДанныеПоказателя.Сотрудник = Сотрудник;
				ДанныеПоказателя.Период = ДатаСобытия;
				ДанныеПоказателя.ГоловнаяОрганизация = ГоловнаяОрганизация;

				ДанныеПоказателя.Показатель = СтрокаСДополнительнымПоказателем.Показатель;
				ДанныеПоказателя.ДокументОснование = Неопределено;
				ДанныеПоказателя.Значение = СтрокаСДополнительнымПоказателем.Значение;
			КонецЦикла;
			
		КонецЕсли; 
				
	КонецЦикла;
	
КонецПроцедуры

Процедура РезультатРасчетаВторичныхДанныхПоСотрудникамВДанныеФормы(Форма, РезультатРасчета, ГоловнаяОрганизация, ОписаниеТаблицаНачислений, ОписаниеТаблицыТарифныхСтавок = Неопределено) Экспорт
		
	ДанныеНачислений = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицаНачислений.ПутьКДанным);	
	
	РассчитанныеДанныеФОТ = РезультатРасчета.ПлановыйФОТ;
	РассчитанныеТарифныеСтавки = РезультатРасчета.ТарифныеСтавки;
	
	РассчитанныеДанныеФОТ.Индексы.Добавить("Сотрудник, Начисление, ДокументОснование, ГоловнаяОрганизация");
	СтруктураПоиска = Новый Структура("Сотрудник, Начисление, ДокументОснование, ГоловнаяОрганизация");
	
	СтруктураПоиска.ГоловнаяОрганизация = ГоловнаяОрганизация;
	
	Для Каждого СтрокаТаблицыФормы Из ДанныеНачислений Цикл
		ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтрокаТаблицыФормы);
		СтруктураПоиска.Сотрудник = СтрокаТаблицыФормы[ОписаниеТаблицаНачислений.ИмяРеквизитаСотрудник];
		
		НайденныеСтроки = РассчитанныеДанныеФОТ.НайтиСтроки(СтруктураПоиска);
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			СтрокаТаблицыФормы.Размер = НайденныеСтроки[0].ВкладВФОТ;
		КонецЕсли;
	КонецЦикла;	
		
	Если ОписаниеТаблицыТарифныхСтавок <> Неопределено Тогда
		РассчитанныеТарифныеСтавки.Индексы.Добавить("Сотрудник, ГоловнаяОрганизация");
		СтруктураПоиска = Новый Структура("Сотрудник, ГоловнаяОрганизация");
		СтруктураПоиска.ГоловнаяОрганизация = ГоловнаяОрганизация;

		ТаблицаТарифныхСтавок = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицыТарифныхСтавок.ПутьКДаннымТаблицы);
		
		Для Каждого СтрокаТаблицыФормы Из ТаблицаТарифныхСтавок Цикл
		    СтруктураПоиска.Сотрудник = СтрокаТаблицыФормы[ОписаниеТаблицыТарифныхСтавок.СотрудникПутьКДанным];
			
			НайденныеСтроки = РассчитанныеТарифныеСтавки.НайтиСтроки(СтруктураПоиска);
			
			Если НайденныеСтроки.Количество() > 0 Тогда
				СтрокаТаблицыФормы[ОписаниеТаблицыТарифныхСтавок.ВидТарифнойСтавкиПутьКДанным] = НайденныеСтроки[0].ВидТарифнойСтавки;
				СтрокаТаблицыФормы[ОписаниеТаблицыТарифныхСтавок.СовокупнаяТарифнаяСтавкаПутьКДанным] = НайденныеСтроки[0].СовокупнаяТарифнаяСтавка;
			КонецЕсли;	
				
		КонецЦикла;	
	КонецЕсли;	
	
КонецПроцедуры	

#КонецОбласти