#Область СлужебныйПрограммныйИнтерфейс

Функция СведенияОДоходахНДФЛДокумента(ДокументОбъект, ТаблицыНачислений, ДополнительныеСведения, СписокФизическихЛиц = Неопределено, ПараметрыЗапроса = Неопределено, УсловияЗапроса = Неопределено, АдресТаблицыРаспределенияПоТерриториямУсловиямТруда = Неопределено) Экспорт 
	
	МесяцНачисления = ДополнительныеСведения.МесяцНачисления;
	ПорядокВыплаты = ДополнительныеСведения.ПорядокВыплаты;
	ПланируемаяДатаВыплаты = ДополнительныеСведения.ПланируемаяДатаВыплаты;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	СоздатьВТНачисленияДокументаДляФормированияДоходовНДФЛ(МенеджерВременныхТаблиц, ДокументОбъект, ТаблицыНачислений, СписокФизическихЛиц, ПараметрыЗапроса, УсловияЗапроса, АдресТаблицыРаспределенияПоТерриториямУсловиямТруда);
	
	Запрос = Новый Запрос;
	
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	Начисления.СуммаВычетаНДФЛ КАК СуммаВычета,
	               |	Начисления.КодВычетаНДФЛ КАК КодВычета,
	               |	Начисления.*
	               |ИЗ
	               |	ВТНачисления КАК Начисления
	               |ГДЕ
	               |	Начисления.КодВычетаНДФЛ <> ЗНАЧЕНИЕ(Справочник.ВидыВычетовНДФЛ.ПустаяСсылка)";
				   
	ВычетыКДоходам = Запрос.Выполнить().Выгрузить();
	
	СведенияОДоходахНДФЛ = РегистрыНакопления.СведенияОДоходахНДФЛ.СоздатьНаборЗаписей();
	СведенияОДоходахНДФЛ.Отбор.Регистратор.Установить(Документы.НачислениеЗарплаты.ПустаяСсылка());
	
	Движения = Новый Структура;
	Движения.Вставить("СведенияОДоходахНДФЛ", СведенияОДоходахНДФЛ);
	
	ДатаОперацииПоНалогам = УчетНДФЛ.ДатаОперацииПоДокументу(ДокументОбъект.Дата, МесяцНачисления);
	ОкончательныйРасчет = Не РасчетЗарплатыРасширенный.ЭтоМежрасчетнаяВыплата(ПорядокВыплаты);
	
	УчетНДФЛРасширенный.СформироватьДоходыНДФЛПоНачислениям(Движения, Ложь, ДокументОбъект.Организация, ДатаОперацииПоНалогам, 
		ПланируемаяДатаВыплаты, МенеджерВременныхТаблиц, МесяцНачисления, Ложь, ОкончательныйРасчет, , ДокументОбъект.Ссылка);
		
	СведенияОДоходах = СведенияОДоходахНДФЛ.Выгрузить();	
		
	Возврат Новый Структура("ВычетыКДоходам,СведенияОДоходах", ВычетыКДоходам, СведенияОДоходах);
	
КонецФункции

Процедура ОбработатьСообщенияПроверкиЗаполнения(Форма, ОписаниеТаблицы) Экспорт
	
	МассивИдентификаторовСтрок = Новый Массив;
	
	СообщенияПроверкиЗаполнения = ПолучитьСообщенияПользователю();
	Если СообщенияПроверкиЗаполнения <> Неопределено Тогда
		
		ДанныеТабличнойЧасти = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеТаблицы.ПутьКДанным);
		Для каждого СообщениеПроверки Из СообщенияПроверкиЗаполнения Цикл
			Если СтрНайти(СообщениеПроверки.Поле,  ОписаниеТаблицы.ИмяТаблицы + "[") > 0 Тогда
				
				ПолеСЛева = Сред(СообщениеПроверки.Поле, СтрНайти(СообщениеПроверки.Поле,  "[") + 1);
				Попытка
					ИндексСтроки = Число(Лев(ПолеСЛева, СтрНайти(ПолеСЛева,  "]") - 1));
					МассивИдентификаторовСтрок.Добавить(ДанныеТабличнойЧасти[ИндексСтроки].ПолучитьИдентификатор());
				Исключение
					
				КонецПопытки;
				
			КонецЕсли; 
		КонецЦикла;
		
	КонецЕсли; 
	
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "МассивИдентификаторовСтрокНДФЛСОшибками", Новый ФиксированныйМассив(МассивИдентификаторовСтрок));
	
КонецПроцедуры

Функция СведенияОбНДФЛ(Форма, ФизическоеЛицо = Неопределено, ПутьКДаннымАдресРаспределенияРезультатовВХранилище = Неопределено) Экспорт
	
	ДанныеОбНДФЛ = Новый Структура;
	Если ФизическоеЛицо = Неопределено Тогда
		
		КоллекцияСтрокНДФЛ = Форма.Объект.НДФЛ.Выгрузить();
		КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных = Форма.Объект.ПримененныеВычетыНаДетейИИмущественные.Выгрузить();
		
	Иначе
		
		СтруктураОтбора = Новый Структура("ФизическоеЛицо", ФизическоеЛицо);
		КоллекцияСтрокНДФЛ = Форма.Объект.НДФЛ.Выгрузить(СтруктураОтбора);
		
		Если Форма.Объект.ПримененныеВычетыНаДетейИИмущественные.Количество() = 0 Тогда
			КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных =	Форма.Объект.ПримененныеВычетыНаДетейИИмущественные.Выгрузить();
		Иначе
			
			КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных =	Форма.Объект.ПримененныеВычетыНаДетейИИмущественные.Выгрузить(
				ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Форма.Объект.ПримененныеВычетыНаДетейИИмущественные[0]));
				
			КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных.Очистить();
			
			ИдентификаторыСтрокНДФЛ = Новый Соответствие;
			Для Каждого СтрокаНДФЛ Из КоллекцияСтрокНДФЛ Цикл
				ИдентификаторыСтрокНДФЛ.Вставить(СтрокаНДФЛ.ИдентификаторСтрокиНДФЛ, Истина);
			КонецЦикла;
			
			Для Каждого СтрокаВычетов Из Форма.Объект.ПримененныеВычетыНаДетейИИмущественные Цикл
				
				Если ИдентификаторыСтрокНДФЛ.Получить(СтрокаВычетов.ИдентификаторСтрокиНДФЛ) = Истина Тогда
					ЗаполнитьЗначенияСвойств(КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных.Добавить(), СтрокаВычетов);
				КонецЕсли; 
				
			КонецЦикла;
		
		КонецЕсли;
		
	КонецЕсли;
	
	ДанныеОбНДФЛ.Вставить("НДФЛ", КоллекцияСтрокНДФЛ);
	ДанныеОбНДФЛ.Вставить("ПримененныеВычетыНаДетейИИмущественные", КоллекцияСтрокПримененныхВычетовНаДетейИИмущественных);
	
	Если ПутьКДаннымАдресРаспределенияРезультатовВХранилище <> Неопределено Тогда
		ДанныеОбНДФЛ.Вставить("АдресРаспределенияРезультатовВХранилище", Форма[ПутьКДаннымАдресРаспределенияРезультатовВХранилище]);
	КонецЕсли; 
	
	Возврат ПоместитьВоВременноеХранилище(ДанныеОбНДФЛ, Форма.УникальныйИдентификатор);
	
КонецФункции

Функция РасчетНДФЛНарастающимИтогомСНачалаГода(ОбъектКодомДоходаНДФЛ) Экспорт
	
	РасчетНДФЛНарастающимИтогомСНачалаГода = Ложь;
	
	Если ЗначениеЗаполнено(ОбъектКодомДоходаНДФЛ) Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		
		КодДоходаНДФЛ = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОбъектКодомДоходаНДФЛ, "КодДоходаНДФЛ");
		Если ЗначениеЗаполнено(КодДоходаНДФЛ) Тогда
			СтавкаНалогообложенияРезидента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(КодДоходаНДФЛ, "СтавкаНалогообложенияРезидента");
			РасчетНДФЛНарастающимИтогомСНачалаГода = (СтавкаНалогообложенияРезидента = Перечисления.НДФЛСтавкиНалогообложенияРезидента.Ставка13);
		КонецЕсли; 
		
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
	Возврат РасчетНДФЛНарастающимИтогомСНачалаГода;
	
КонецФункции

Функция ДополнительныеДанныеДляПолученияСведенийОДоходахНДФЛДокумента() Экспорт 
	
	ДополнительныеСведения = Новый Структура;
	ДополнительныеСведения.Вставить("МесяцНачисления");
	ДополнительныеСведения.Вставить("ПорядокВыплаты");
	ДополнительныеСведения.Вставить("ПланируемаяДатаВыплаты");
	
	Возврат ДополнительныеСведения;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДополнитьФормуПанельюВычетов(Форма, ОписаниеПанелиВычеты = Неопределено, ДобавлятьЭлементыФормы = Истина, ДобавлятьРеквизитыФормы = Истина, ОтложенноеИзменение = Ложь) Экспорт
	
	Перем ВычетыЛичные;
	Перем ВычетыНаДетейИИмущественные;
	Перем ВычетыКДоходам;
	
	УчетНДФЛФормыБазовый.ДополнитьФормуПанельюВычетов(Форма, ОписаниеПанелиВычеты, ДобавлятьЭлементыФормы, ДобавлятьРеквизитыФормы, ОтложенноеИзменение);
	
	Если ДобавлятьЭлементыФормы Тогда
	
		Если ОписаниеПанелиВычеты = Неопределено Тогда 
			ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаСервере();
		КонецЕсли;
		
		ГруппаФормыПанельВычеты = Форма.Элементы.Найти(ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты);
		
		НастраиваемыеПанели = ОписаниеПанелиВычеты.НастраиваемыеПанели;
		
		// Панель Вычеты личные
		ВычетыЛичные = НастраиваемыеПанели.Получить("ВычетыЛичные");
		Если ВычетыЛичные <> Неопределено Тогда
			
			ГруппаВычетыЛичные = Форма.Элементы.Найти(ГруппаФормыПанельВычеты.Имя + "ГруппаВычетыЛичные");
			Если ГруппаВычетыЛичные <> Неопределено Тогда
				
				ТекстПредупрежденияПриРедактировании = НСтр("ru = 'НДФЛ рассчитан автоматически, его редактирование не рекомендуется. Редактирование следует выполнять только в том случае, если вы полностью уверены в своих действиях'");
				
				ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
					Форма.Элементы,
					ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКодВычета",
					"ПредупреждениеПриРедактировании",
					ТекстПредупрежденияПриРедактировании);
				
				ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
					Форма.Элементы,
					ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичный",
					"ПредупреждениеПриРедактировании",
					ТекстПредупрежденияПриРедактировании);
				
				ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
					Форма.Элементы,
					ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозвратуКодВычета",
					"ПредупреждениеПриРедактировании",
					ТекстПредупрежденияПриРедактировании);
				
				ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
					Форма.Элементы,
					ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозврату",
					"ПредупреждениеПриРедактировании",
					ТекстПредупрежденияПриРедактировании);
				
			КонецЕсли;
			
		КонецЕсли;
		
		// Установим условное оформление.
		УсловноеОформление = Форма.УсловноеОформление;
		
		ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
		ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(,,Истина));
		
		ЭлементОтбора = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = Истина;
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ПутьКДаннымНДФЛ + ".ФиксРасчет" );
		ЭлементОтбора.ПравоеЗначение = Истина;
		
		Если ВычетыЛичные <> Неопределено Тогда
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКодВычета");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичный");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозвратуКодВычета");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозврату");
			
		КонецЕсли;
		
		Если ВычетыНаДетейИИмущественные <> Неопределено Тогда
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыНаДетейИИмущественныеКодВычета");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыНаДетейИИмущественныеРазмерВычета");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыНаДетейИИмущественныеОписание");
		
		КонецЕсли;
		
		Если ВычетыКДоходам <> Неопределено Тогда
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыКДоходамНачисление");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыКДоходамСуммаВычета");
			
			ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить(); 
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ГруппаФормыПанельВычеты.Имя + "ВычетыКДоходамКодВычета");
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ДополнитьМассивРеквизитовПанелиВычетов(Форма, МассивДобавляемыхРеквизитов, МассивИменРеквизитовФормы, ОписаниеПанелиВычеты = Неопределено) Экспорт
	
	УчетНДФЛФормыБазовый.ДополнитьМассивРеквизитовПанелиВычетов(Форма, МассивДобавляемыхРеквизитов, МассивИменРеквизитовФормы, ОписаниеПанелиВычеты);
	
	Если ОписаниеПанелиВычеты = Неопределено Тогда 
		ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаСервере();
	КонецЕсли;
	
	НастраиваемыеПанели = ОписаниеПанелиВычеты.НастраиваемыеПанели;
	
	// Панель ВычетыНаДетейИИмущественные
	ВычетыНаДетейИИмущественные = НастраиваемыеПанели.Получить("ВычетыНаДетейИИмущественные");
	Если ВычетыНаДетейИИмущественные <> Неопределено Тогда
		
		Реквизит = Новый РеквизитФормы("МассивИдентификаторовСтрокНДФЛСОшибками", 
			Новый ОписаниеТипов());
		МассивДобавляемыхРеквизитов.Добавить(Реквизит);
		
	КонецЕсли;
	
	// Панель ВычетыКДоходам
	ВычетыКДоходам = НастраиваемыеПанели.Получить("ВычетыКДоходам");
	Если ВычетыКДоходам <> Неопределено Тогда
		
		Реквизит = Новый РеквизитФормы("СуммаВычетаПредыдущая", 
			Новый ОписаниеТипов("Число"),
			ВычетыКДоходам);
		МассивДобавляемыхРеквизитов.Добавить(Реквизит);
			
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьФиксРасчетСтрокНДФЛ(Форма, СтруктураПоиска) Экспорт
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаСервере();

	ДанныеНДФЛ = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ПутьКДаннымНДФЛ);
	СтрокиНДФЛ = ДанныеНДФЛ.НайтиСтроки(СтруктураПоиска);
	Для Каждого СтрокаНДФЛ Из СтрокиНДФЛ Цикл
		СтрокаНДФЛ.ФиксРасчет = Истина;
	КонецЦикла;
		
КонецПроцедуры

Процедура УстановитьПараметрыВыбораСотрудниковВДокументахПредоставленияВычетов(Форма, ИмяЭлементаСотрудник) Экспорт
	
	ЭлементФормы = Форма.Элементы.Найти(ИмяЭлементаСотрудник);
	Если ЭлементФормы <> Неопределено Тогда
		
		ОтборУстановлен = Ложь;
		
		ПараметрыВыбора = Новый Массив(ЭлементФормы.ПараметрыВыбора);
		Для каждого ПараметрВыбора Из ПараметрыВыбора Цикл
			
			Если ВРег(ПараметрВыбора.Имя) = ВРег("Отбор.Роль") Тогда
				
				ОтборУстановлен = Истина;
				Прервать;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если Не ОтборУстановлен Тогда
			
			РолиСотрудника = Новый Массив;
			РолиСотрудника.Добавить(Перечисления.РолиФизическихЛиц.Сотрудник);
			РолиСотрудника.Добавить(Перечисления.РолиФизическихЛиц.БывшийСотрудник);
			РолиСотрудника.Добавить(Перечисления.РолиФизическихЛиц.ПрочийПолучательДоходов);
			
			ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Роль", Новый ФиксированныйМассив(РолиСотрудника)));
			
			ЭлементФормы.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
			
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

Функция ФормаПодробнееОРасчетеНДФЛКонтролируемыеПоляДляФиксацииРезультатов() Экспорт
	
	Возврат Новый Структура("НДФЛ", УчетНДФЛРасширенный.КонтролируемыеПоляДляФиксацииРезультатов());
	
КонецФункции

Процедура ФормаПодробнееОРасчетеНДФЛПриЗаполнении(Форма, ОписаниеТаблицыНДФЛ, ОписанияТаблицДляРаспределения) Экспорт
	
	РасчетЗарплатыРасширенныйФормы.ДокументыВыполненияНачисленийДополнитьФорму(Форма, ОписаниеТаблицыНДФЛ, "");
	РасчетЗарплатыРасширенныйФормы.ДокументыНачисленийДополнитьФормуРезультатыРаспределения(Форма, ОписанияТаблицДляРаспределения);
	
КонецПроцедуры

#Область ПодробнееОРасчетеНДФЛ

Процедура СоздатьВТНачисленияДокументаДляФормированияДоходовНДФЛ(МенеджерВременныхТаблиц, ДокументОбъект, ТаблицыНачислений, СписокФизическихЛиц, ПараметрыЗапроса, УсловияЗапроса, АдресТаблицыРаспределенияПоТерриториямУсловиямТруда = Неопределено) 
	
	// Получаем массив имен табличных частей.
	ИменаТаблицНачислений = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ТаблицыНачислений);
	
	Запрос = Новый Запрос;
	
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Если СписокФизическихЛиц <> Неопределено Тогда
		Запрос.УстановитьПараметр("СписокФизическихЛиц", СписокФизическихЛиц);
	КонецЕсли; 
	
	Если ЗарплатаКадрыРасширенный.ИспользоватьРаспределениеПоТерриториямУсловиямТруда(ДокументОбъект.Организация) Тогда
		ТаблицаНачислений = СформироватьНачисленияРаспределениеПоТерриториямДокумента(ДокументОбъект, ИменаТаблицНачислений, 
			АдресТаблицыРаспределенияПоТерриториямУсловиямТруда);
		ТекстЗапроса = 
			"ВЫБРАТЬ
			|	Начисления.Сотрудник КАК Сотрудник,
			|	Начисления.ПериодДействия КАК ПериодДействия,
			|	Начисления.ДатаНачала КАК ДатаНачала,
			|	Начисления.Начисление КАК Начисление,
			|	ВЫБОР
			|		КОГДА Начисления.РезультатТерритории <> 0
			|			ТОГДА Начисления.РезультатТерритории
			|		ИНАЧЕ Начисления.Результат
			|	КОНЕЦ КАК Сумма,
			|	Начисления.Сторно КАК Сторно,
			|	Начисления.ФиксСторно КАК ФиксСторно,
			|	Начисления.СторнируемыйДокумент КАК СторнируемыйДокумент,
			|	Начисления.ИдентификаторСтроки КАК ИдентификаторСтроки,
			|	ВЫБОР
			|		КОГДА Начисления.СуммаВычетаТерритории <> 0
			|			ТОГДА Начисления.СуммаВычетаТерритории
			|		ИНАЧЕ Начисления.СуммаВычета
			|	КОНЕЦ КАК СуммаВычета,
			|	Начисления.КодВычета КАК КодВычета,
			|	ВЫБОР
			|		КОГДА Начисления.МестоПолученияДохода ЕСТЬ НЕ NULL 
			|				И Начисления.МестоПолученияДохода <> НЕОПРЕДЕЛЕНО
			|				И Начисления.МестоПолученияДохода <> ЗНАЧЕНИЕ(Справочник.ТерриторииВыполненияРабот.ПустаяСсылка)
			|				И Начисления.МестоПолученияДохода <> ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка)
			|			ТОГДА Начисления.МестоПолученияДохода
			|		КОГДА Начисления.Территория ЕСТЬ НЕ NULL 
			|				И Начисления.Территория <> НЕОПРЕДЕЛЕНО
			|				И Начисления.Территория <> ЗНАЧЕНИЕ(Справочник.ТерриторииВыполненияРабот.ПустаяСсылка)
			|			ТОГДА Начисления.Территория
			|		ИНАЧЕ Начисления.Подразделение
			|	КОНЕЦ КАК Подразделение
			|ПОМЕСТИТЬ ВТЗаписиНачислений
			|ИЗ
			|	&ТаблицаНачислений КАК Начисления";
	Иначе
		ТаблицаНачислений = СформироватьНачисленияДокумента(ДокументОбъект, ИменаТаблицНачислений);
		ТекстЗапроса = 
			"ВЫБРАТЬ
			|	Начисления.Сотрудник КАК Сотрудник,
			|	Начисления.ПериодДействия КАК ПериодДействия,
			|	Начисления.ДатаНачала КАК ДатаНачала,
			|	Начисления.Начисление КАК Начисление,
			|	Начисления.Результат КАК Сумма,
			|	Начисления.Сторно КАК Сторно,
			|	Начисления.ФиксСторно КАК ФиксСторно,
			|	Начисления.СторнируемыйДокумент КАК СторнируемыйДокумент,
			|	Начисления.ИдентификаторСтроки КАК ИдентификаторСтроки,
			|	Начисления.СуммаВычета КАК СуммаВычета,
			|	Начисления.КодВычета КАК КодВычета,
			|	ВЫБОР
			|		КОГДА Начисления.МестоПолученияДохода ЕСТЬ НЕ NULL 
			|			И Начисления.МестоПолученияДохода <> НЕОПРЕДЕЛЕНО
			|			И Начисления.МестоПолученияДохода <> ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка)
			|		ТОГДА Начисления.МестоПолученияДохода
			|		ИНАЧЕ Начисления.Подразделение
			|	КОНЕЦ КАК Подразделение
			|ПОМЕСТИТЬ ВТЗаписиНачислений
			|ИЗ
			|	&ТаблицаНачислений КАК Начисления";
	КонецЕсли;
	
	Если ПараметрыЗапроса <> Неопределено Тогда 
		Для Каждого КлючИЗначение Из ПараметрыЗапроса Цикл
			ИмяПоля = КлючИЗначение.Ключ;
			ЗначениеПараметра = КлючИЗначение.Значение;
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Начисления." + ИмяПоля + " КАК", "&" + ИмяПоля + " КАК");
			Запрос.УстановитьПараметр(ИмяПоля, ЗначениеПараметра);
		КонецЦикла;
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ТаблицаНачислений", ТаблицаНачислений);
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();
	
	ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ЗаписиНачислений.ИдентификаторСтроки,
		|	ЗаписиНачислений.Сотрудник,
		|	ЗаписиНачислений.Сотрудник.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ЗаписиНачислений.ДатаНачала,
		|	ЗаписиНачислений.Начисление,
		|	ЗаписиНачислений.Сумма КАК СуммаДохода,
		|	ЗаписиНачислений.СуммаВычета КАК СуммаВычетаНДФЛ,
		|	ЗаписиНачислений.КодВычета КАК КодВычетаНДФЛ,
		|	ЗаписиНачислений.Подразделение,
		|	ЗаписиНачислений.Подразделение КАК ПодразделениеОрганизации,
		|	ЗаписиНачислений.Сторно
		|		ИЛИ ЗаписиНачислений.ФиксСторно КАК Сторно,
		|	ЗаписиНачислений.СторнируемыйДокумент
		|ПОМЕСТИТЬ ВТНачисления
		|ИЗ
		|	ВТЗаписиНачислений КАК ЗаписиНачислений";
	
	Условия = Новый Массив;
	Если СписокФизическихЛиц <> Неопределено Тогда
		Условия.Добавить("ЗаписиНачислений.Сотрудник.ФизическоеЛицо В (&СписокФизическихЛиц)");
	КонецЕсли;
	
	Если УсловияЗапроса <> Неопределено Тогда
		Для Каждого КлючИЗначение Из УсловияЗапроса Цикл
			Условия.Добавить("ЗаписиНачислений." + КлючИЗначение.Ключ + " = &" + КлючИЗначение.Ключ);
			Запрос.УстановитьПараметр(КлючИЗначение.Ключ, КлючИЗначение.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Если Условия.Количество() > 0 Тогда
		УсловияСтрокой = СтрСоединить(Условия, Символы.ПС + Символы.Таб + "И ");
		ТекстЗапроса = ТекстЗапроса + "
		|	ГДЕ " + УсловияСтрокой;
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();
	
КонецПроцедуры

Функция СформироватьНачисленияРаспределениеПоТерриториямДокумента(ДокументОбъект, ИменаТаблицНачислений, 
АдресТаблицыРаспределенияПоТерриториямУсловиямТруда = Неопределено)
			
	ТаблицаНачислений = РасчетЗарплатыРасширенный.ПустаяТаблицаНачисления(Истина);
	ТаблицаНачислений.Колонки.Добавить("Территория", Новый ОписаниеТипов("СправочникСсылка.ТерриторииВыполненияРабот"));
	ТаблицаНачислений.Колонки.Добавить("РезультатТерритории", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
	ТаблицаНачислений.Колонки.Добавить("СуммаВычетаТерритории", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
	ТаблицаНачислений.Колонки.Добавить("СкидкаПоВзносамТерритории", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
	
	Если ЗначениеЗаполнено(АдресТаблицыРаспределенияПоТерриториямУсловиямТруда) Тогда
		ДанныеРаспределенияПоТерриториямУсловиямТруда = ПолучитьИзВременногоХранилища(АдресТаблицыРаспределенияПоТерриториямУсловиямТруда);
		ОбщегоНазначенияБЗК.ДобавитьИндексКоллекции(ДанныеРаспределенияПоТерриториямУсловиямТруда, "ИдентификаторСтроки");
	КонецЕсли;

	Для Каждого ИмяТаблицыНачислений Из ИменаТаблицНачислений Цикл
		Для Каждого СтрокаТаблицыДокумента Из ДокументОбъект[ИмяТаблицыНачислений] Цикл
			Распределения = РасчетЗарплатыРасширенныйФормы.ПолучитьРаспределениеПоТерриториямУсловиямТрудаПоСтроке(СтрокаТаблицыДокумента, 
				СтрокаТаблицыДокумента.ИдентификаторСтрокиВидаРасчета, ДанныеРаспределенияПоТерриториямУсловиямТруда);	
			Если ЗначениеЗаполнено(Распределения) Тогда
				Для Каждого Распределение Из Распределения Цикл
					СтрокаТаблицыНачислений = ТаблицаНачислений.Добавить();
					СтрокаТаблицыНачислений.Территория = Распределение.Территория;
					СтрокаТаблицыНачислений.РезультатТерритории = Распределение.Результат;
					СтрокаТаблицыНачислений.СуммаВычетаТерритории = Распределение.СуммаВычета;
					СтрокаТаблицыНачислений.СкидкаПоВзносамТерритории = Распределение.СкидкаПоВзносам;
					ЗаполнитьЗначенияСвойств(СтрокаТаблицыНачислений, СтрокаТаблицыДокумента);
				КонецЦикла;
			Иначе
				СтрокаТаблицыНачислений = ТаблицаНачислений.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаТаблицыНачислений, СтрокаТаблицыДокумента);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат ТаблицаНачислений;
	
КонецФункции

Функция СформироватьНачисленияДокумента(ДокументОбъект, ИменаТаблицНачислений)
			
	ТаблицаНачислений = РасчетЗарплатыРасширенный.ПустаяТаблицаНачисления(Истина);
	
	Для Каждого ИмяТаблицыНачислений Из ИменаТаблицНачислений Цикл
		Для Каждого СтрокаТаблицыДокумента Из ДокументОбъект[ИмяТаблицыНачислений] Цикл
			СтрокаТаблицыНачислений = ТаблицаНачислений.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицыНачислений, СтрокаТаблицыДокумента);
		КонецЦикла;
	КонецЦикла;
	
	Возврат ТаблицаНачислений;
	
КонецФункции

#КонецОбласти

#КонецОбласти
