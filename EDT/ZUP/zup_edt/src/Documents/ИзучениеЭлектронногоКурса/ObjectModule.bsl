#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	// Делаем проверки
	//
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если РежимЗаписи = РежимЗаписиДокумента.Запись
		ИЛИ РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
	
		Если НЕ ЗначениеЗаполнено(Учащийся) Тогда
			ВызватьИсключение НСтр("ru = 'Требуется указать учащегося'");
		КонецЕсли;		
		
		Если НЕ ЗначениеЗаполнено(ЭлектронныйКурс) Тогда
			ВызватьИсключение НСтр("ru = 'Требуется указать электронный курс'");
		КонецЕсли;
		
	КонецЕсли;		
		
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	СформироватьДвижения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

Процедура СформироватьДвижения() Экспорт
	
	Движения.ИзученныеЭлектронныеКурсы.Записывать = Истина;
	Движения.ИзученныеЭлементыЭлектронныхКурсов.Записывать = Истина;
	Движения.ПопыткиИзученияЭлементовЭлектронныхКурсов.Записывать = Истина;		
	Движения.ОтветыНаТестовыеВопросы.Записывать = Истина;	
	Движения.ВыбранныеВариантыОтветовЭлектронныхВопросов.Записывать = Истина;
	
	// Получаем структуру данных изучения
	//	
	
	ДанныеИзученияСтрока = ДанныеИзучения.Получить();
	ДанныеИзученияСтруктура = Неопределено;
		
	Если ЗначениеЗаполнено(ДанныеИзученияСтрока) Тогда

		СвойстваСДатами = Новый Массив;
		СвойстваСДатами.Добавить("start");
		СвойстваСДатами.Добавить("end");
		
	 	Чтение = Новый ЧтениеJSON;
	    Чтение.УстановитьСтроку(ДанныеИзученияСтрока);
		ДанныеИзученияСтруктура = ПрочитатьJSON(Чтение, Ложь, , ,"ВосстановлениеЧтенияJSON",ЭтотОбъект,,СвойстваСДатами);
	    Чтение.Закрыть();		
		
	КонецЕсли;

	Если ДанныеИзученияСтруктура = Неопределено Тогда
	
		// ИзученныеЭлектронныеКурсы	
		
		Движение = Движения.ИзученныеЭлектронныеКурсы.Добавить();	
		
		Движение.Период            = Дата;
		Движение.Учащийся          = Учащийся;
		Движение.Контекст          = Контекст;
		Движение.ЭлектронныйКурс   = ЭлектронныйКурс;
		Движение.Завершено         = Ложь;	
		Движение.Результат         = 0;
		Движение.ИзученоВПроцентах = 0; 
		Движение.ПроверяетсяПреподавателем = Ложь;
		Движение.ПроверенПреподавателем = Ложь;
		
		Возврат; // Другие движения не делаем
		
	КонецЕсли;
	
	// Формируем проводки
	//
	
	ПроверяетсяПреподавателем = Ложь;
	ПроверенПреподавателем = Истина;
	
	
	// ИзученныеЭлементыЭлектронныхКурсов
	
	ЭтоКурсSCORM = Ложь;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СодержаниеЭлектронныхКурсов.Ссылка КАК Ссылка,
		|	СодержаниеЭлектронныхКурсов.ТипЭлемента КАК ТипЭлемента
		|ИЗ
		|	Справочник.СодержаниеЭлектронныхКурсов КАК СодержаниеЭлектронныхКурсов
		|ГДЕ
		|	СодержаниеЭлектронныхКурсов.Владелец = &ЭлектронныйКурс
		|	И СодержаниеЭлектронныхКурсов.ПометкаУдаления = ЛОЖЬ
		|	И СодержаниеЭлектронныхКурсов.ЭтоГруппа = ЛОЖЬ";
	
	Запрос.УстановитьПараметр("ЭлектронныйКурс", ЭлектронныйКурс);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаЭлементовСодержания = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаЭлементовСодержания.Следующий() Цикл
		
		Если ВыборкаЭлементовСодержания.ТипЭлемента = Перечисления.ТипыЭлементовСодержанияЭлектронногоКурса.SCO Тогда
			ЭтоКурсSCORM = Истина;
		КонецЕсли;

		ДанныеАктивности = Неопределено;
		ИдентификаторАктивности = Строка(ВыборкаЭлементовСодержания.Ссылка.УникальныйИдентификатор());
		
		Для каждого Activity Из ДанныеИзученияСтруктура.activities Цикл		
			Если Activity.slide = ИдентификаторАктивности Тогда
				ДанныеАктивности = Activity;
				Прервать; // Нашли данные активности элемента содержания
			КонецЕсли;		
		КонецЦикла;
		
		Если ДанныеАктивности = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Движение = Движения.ИзученныеЭлементыЭлектронныхКурсов.Добавить();
		
		Движение.Период = Дата;
		Движение.ИзучениеЭлектронногоКурса = Ссылка;
		Движение.ЭлементСодержания = ВыборкаЭлементовСодержания.Ссылка;
		
		Движение.Изучено = ДанныеАктивности.complete;
		Движение.Результат = ДанныеАктивности.score;
		
		ВремяИзученияВСекундах = 0;
		
		Для каждого ПопыткаИзучения Из ДанныеАктивности.attempts Цикл
			
			Если ПопыткаИзучения.Свойство("start")
				И ЗначениеЗаполнено(ПопыткаИзучения.start)
				И ПопыткаИзучения.Свойство("end")
				И ЗначениеЗаполнено(ПопыткаИзучения.end) Тогда
				
				ВремяИзученияВСекундах = ВремяИзученияВСекундах + (ПопыткаИзучения.end - ПопыткаИзучения.start);
				
			КонецЕсли;
			
		КонецЦикла;
		
		Движение.ВремяИзученияВСекундах = ВремяИзученияВСекундах;
		Движение.ДатаНачала = ДанныеАктивности.start;
		Движение.ДатаОкончания = ?(ДанныеАктивности.Свойство("end"), ДанныеАктивности.end, Неопределено);
		
		Движение.Контекст = Контекст;
		Движение.Учащийся = Учащийся;
		Движение.ЭлектронныйКурс = ЭлектронныйКурс;
		Движение.ЭтоТест = ?(ДанныеАктивности.type = "QUIZ", Истина, Ложь);
		Движение.ПроверяетсяПреподавателем = Ложь;
		Движение.ПроверенПреподавателем = Ложь;		
		Движение.ИдентификаторАктивности = Новый УникальныйИдентификатор(ДанныеАктивности.uuid);
		
		Если Движение.ПроверяетсяПреподавателем Тогда
			ПроверяетсяПреподавателем = Истина;
		КонецЕсли;
		
		Если НЕ Движение.ПроверенПреподавателем Тогда
			ПроверенПреподавателем = Ложь;
		КонецЕсли;		
		
	КонецЦикла;
	
	// ПопыткиИзученияЭлементовЭлектронныхКурсов
	
	Для каждого ДанныеАктивности Из ДанныеИзученияСтруктура.activities Цикл
		
		ВыборкаЭлементовСодержания.Сбросить();
		
		ЭлементСодержания = Справочники.СодержаниеЭлектронныхКурсов.ПолучитьСсылку(Новый УникальныйИдентификатор(ДанныеАктивности.slide));
		
		Если НЕ ВыборкаЭлементовСодержания.НайтиСледующий(ЭлементСодержания, "Ссылка") Тогда
			Продолжить; // Нет элемента содержания в базе
		КонецЕсли;		
		
		Если ДанныеАктивности.type = "QUIZ" Тогда 
			
			Для каждого ПопыткаТестирования Из ДанныеАктивности.quizAttempts Цикл
				
				ТекущееВремяИзученияВСекундах = ПопыткаТестирования.end - ПопыткаТестирования.start;
				
				Если ТекущееВремяИзученияВСекундах < 1 Тогда
					Продолжить;
				КонецЕсли;				
				
				Движение = Движения.ПопыткиИзученияЭлементовЭлектронныхКурсов.Добавить();
				Движение.Период = ПопыткаТестирования.start;
				Движение.Учащийся = Учащийся;
				Движение.ЭлектронныйКурс = ЭлектронныйКурс;
				Движение.ЭлементСодержания = ЭлементСодержания;				
				Движение.Завершено = ПопыткаТестирования.complete;
				Движение.Результат = ПопыткаТестирования.score;
				
				Если Движение.Завершено Тогда
					Движение.ВремяИзученияВСекундах = ТекущееВремяИзученияВСекундах;
				Иначе
					Движение.ВремяИзученияВСекундах = 0;
				КонецЕсли;

				Движение.ДатаНачала = ПопыткаТестирования.start;
				Движение.ДатаОкончания = ?(ПопыткаТестирования.Свойство("end"), ПопыткаТестирования.end, Неопределено);
				Движение.ИдентификаторАктивности = Новый УникальныйИдентификатор(ДанныеАктивности.uuid);
				Движение.ЭтоТест = Истина;				
				Движение.Контекст = Контекст;
				
			КонецЦикла;
			
		Иначе
			
			Для каждого ПопыткаИзучения Из ДанныеАктивности.attempts Цикл
				
				ТекущееВремяИзученияВСекундах = ПопыткаИзучения.end - ПопыткаИзучения.start;
				
				Если ТекущееВремяИзученияВСекундах < 1 Тогда
					Продолжить;
				КонецЕсли;												
				
				Движение = Движения.ПопыткиИзученияЭлементовЭлектронныхКурсов.Добавить();
				Движение.Период = ПопыткаИзучения.start;
				Движение.Учащийся = Учащийся;
				Движение.ЭлектронныйКурс = ЭлектронныйКурс;
				Движение.ЭлементСодержания = ЭлементСодержания;				
				Движение.Завершено = ?(ПопыткаИзучения.Свойство("end") И ЗначениеЗаполнено(ПопыткаИзучения.end), Истина, Ложь);
				Движение.Результат = 0;
				
				Если Движение.Завершено Тогда
					Движение.ВремяИзученияВСекундах = ТекущееВремяИзученияВСекундах;
				Иначе
					Движение.ВремяИзученияВСекундах = 0;
				КонецЕсли;
				
				Движение.ДатаНачала = ПопыткаИзучения.start;
				Движение.ДатаОкончания = ?(ПопыткаИзучения.Свойство("end"), ПопыткаИзучения.end, Неопределено);
				Движение.ИдентификаторАктивности = Новый УникальныйИдентификатор(ДанныеАктивности.uuid);
				Движение.ЭтоТест = Ложь;
				Движение.Контекст = Контекст;
				
			КонецЦикла;
			
		КонецЕсли;
			
	КонецЦикла;
	
	// ОтветыНаТестовыеВопросы и ВыбранныеВариантыОтветовЭлектронныхВопросов
	
	ТаблицаОтветовНаВопросы = Новый ТаблицаЗначений;
	ТаблицаОтветовНаВопросы.Колонки.Добавить("Вопрос");
	ТаблицаОтветовНаВопросы.Колонки.Добавить("ОтветНаВопрос");
	ТаблицаОтветовНаВопросы.Колонки.Добавить("ПопыткаТестирования");	
	ТаблицаОтветовНаВопросы.Колонки.Добавить("ДанныеАктивности");	
	
	Для каждого ДанныеАктивности Из ДанныеИзученияСтруктура.activities Цикл	
		
		Если ДанныеАктивности.type <> "QUIZ" Тогда
			Продолжить;
		КонецЕсли;
		
		ВыборкаЭлементовСодержания.Сбросить();
		
		ЭлементСодержания = Справочники.СодержаниеЭлектронныхКурсов.ПолучитьСсылку(Новый УникальныйИдентификатор(ДанныеАктивности.slide));
		
		Если НЕ ВыборкаЭлементовСодержания.НайтиСледующий(ЭлементСодержания, "Ссылка") Тогда
			Продолжить; // Нет элемента содержания в базе
		КонецЕсли;			
		
		Для каждого ПопыткаТестирования Из ДанныеАктивности.quizAttempts Цикл			
			
			Для каждого СтраницаТестирования Из ПопыткаТестирования.pages Цикл
				
				Для каждого ОтветНаВопрос Из СтраницаТестирования.questions Цикл
					
					Вопрос = Справочники.ТестовыеВопросы.ПолучитьСсылку(Новый УникальныйИдентификатор(ОтветНаВопрос.question));
					
					НоваяСтрокаТО = ТаблицаОтветовНаВопросы.Добавить();
					НоваяСтрокаТО.Вопрос = Вопрос;
					НоваяСтрокаТО.ОтветНаВопрос = ОтветНаВопрос;
					НоваяСтрокаТО.ПопыткаТестирования = ПопыткаТестирования;
					НоваяСтрокаТО.ДанныеАктивности = ДанныеАктивности;
					
				КонецЦикла;
				
			КонецЦикла;
		
		КонецЦикла;
		
	КонецЦикла;
	
	МассивВопросов = ТаблицаОтветовНаВопросы.ВыгрузитьКолонку("Вопрос"); 	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТестовыеВопросы.Ссылка КАК Ссылка,
		|	ТестовыеВопросы.ТипВопроса КАК ТипВопроса
		|ИЗ
		|	Справочник.ТестовыеВопросы КАК ТестовыеВопросы
		|ГДЕ
		|	ТестовыеВопросы.Ссылка В(&МассивВопросов)
		|	И ТестовыеВопросы.ПометкаУдаления = ЛОЖЬ";
	
	Запрос.УстановитьПараметр("МассивВопросов", МассивВопросов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаВопросов = РезультатЗапроса.Выбрать(); // Выбираем вопросы, которые есть в базе
	
	Пока ВыборкаВопросов.Следующий() Цикл
		
		ОтветыНаВопрос = ТаблицаОтветовНаВопросы.НайтиСтроки(Новый Структура("Вопрос", ВыборкаВопросов.Ссылка));
		
		Для каждого СтрокаТО Из ОтветыНаВопрос Цикл
		
			Движение = Движения.ОтветыНаТестовыеВопросы.Добавить();
			Движение.Период = СтрокаТО.ОтветНаВопрос.start;
			Движение.Учащийся = Учащийся;
			Движение.Вопрос = ВыборкаВопросов.Ссылка;
			Движение.ОтветПолучен = СтрокаТО.ОтветНаВопрос.complete;
			Движение.Результат = СтрокаТО.ОтветНаВопрос.score;
			Движение.ИдентификаторАктивности = Новый УникальныйИдентификатор(СтрокаТО.ДанныеАктивности.uuid);
			Движение.ИдентификаторПопыткиТестирования = Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.uuid);
			Движение.Контекст = Контекст;
			Движение.ЭлектронныйКурс = ЭлектронныйКурс;
			Движение.ЭлементСодержания = Справочники.СодержаниеЭлектронныхКурсов.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.slide));
			Движение.ЭлектронныйТест = Справочники.ЭлектронныеТесты.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.quiz)); // Наличие в базе шаблона теста не проверяем
			
			Если ВыборкаВопросов.ТипВопроса = Перечисления.ТипыТестовыхВопросов.ОдинИзМногих
				ИЛИ ВыборкаВопросов.ТипВопроса = Перечисления.ТипыТестовыхВопросов.МногиеИзМногих Тогда
				
				НомерВарианта = 1;
				
				Для каждого ВариантОтвета Из СтрокаТО.ОтветНаВопрос.variants Цикл
				
					Движение = Движения.ВыбранныеВариантыОтветовЭлектронныхВопросов.Добавить();
					Движение.Период = СтрокаТО.ОтветНаВопрос.start;
					Движение.Вопрос = ВыборкаВопросов.Ссылка;
					Движение.ВариантОтвета = Справочники.ВариантыОтветовНаТестовыеВопросы.ПолучитьСсылку(Новый УникальныйИдентификатор(ВариантОтвета.variant)); // Наличие в базе варианта ответа не проверяем
					Движение.Выбран = ВариантОтвета.selected;
					Движение.ВерныйВыбран = ВариантОтвета.trueSelected;
					Движение.ВерныйНеВыбран = ВариантОтвета.trueNotSelected;
					Движение.ОшибочныйВыбран = ВариантОтвета.falseSelected;
					Движение.ОшибочныйНеВыбран = ВариантОтвета.falseNotSelected;
					Движение.Номер = НомерВарианта;
					Движение.Учащийся = Учащийся;
					Движение.ЭлементСодержания = Справочники.СодержаниеЭлектронныхКурсов.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.slide));
					Движение.Контекст = Контекст;
					Движение.ЭлектронныйКурс = ЭлектронныйКурс;
					Движение.ЭлектронныйТест = Справочники.ЭлектронныеТесты.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.quiz)); // Наличие в базе шаблона теста не проверяем
					Движение.ИдентификаторПопыткиТестирования = Новый УникальныйИдентификатор(СтрокаТО.ПопыткаТестирования.uuid);
					
					НомерВарианта = НомерВарианта + 1;
					
				КонецЦикла;				
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	// SCORM
	
	Если ЭтоКурсSCORM Тогда
		
		// Для курсов SCORM считаем прогресс, оценку и завершенность вручную
		
		МаксимальныйПрогрессЭлементовSCORM = 0;
		ПрогрессЭлементовSCORM = 0;	
		
		МаксимальныйБаллSCORM = 0;
		РеальныйБаллSCORM = 0;
		
		ВыборкаЭлементовСодержания.Сбросить();
		Пока ВыборкаЭлементовСодержания.Следующий() Цикл
			
			МаксимальныйПрогрессЭлементовSCORM = МаксимальныйПрогрессЭлементовSCORM + 100;			
			
			ДанныеАктивности = Неопределено;
			ИдентификаторАктивности = Строка(ВыборкаЭлементовСодержания.Ссылка.УникальныйИдентификатор());
			
			Для каждого Activity Из ДанныеИзученияСтруктура.activities Цикл		
				Если Activity.slide = ИдентификаторАктивности Тогда
					ДанныеАктивности = Activity;
					Прервать; // Нашли данные активности элемента содержания
				КонецЕсли;		
			КонецЦикла;
			
			Если ДанныеАктивности = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			Если ВыборкаЭлементовСодержания.ТипЭлемента = Перечисления.ТипыЭлементовСодержанияЭлектронногоКурса.SCO Тогда				
				
				МаксимальныйБаллSCORM = МаксимальныйБаллSCORM + 100;
				
				ПрогрессЭтойАктивности = 0;
				МаксимальныйБаллЭтойАктивности = 0;
				
				Для каждого ПопыткаSCORMАктивности Из ДанныеАктивности.scoAttempts Цикл
					ТекущийПрогрессЧисло = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(ПопыткаSCORMАктивности.cmi.progress_measure);
					Если ТекущийПрогрессЧисло = Неопределено Тогда
						ТекущийПрогрессЧисло = 0;
					КонецЕсли;
					ТекущийПрогрессЧисло = ТекущийПрогрессЧисло * 100;
					Если ТекущийПрогрессЧисло > ПрогрессЭтойАктивности Тогда
						ПрогрессЭтойАктивности = ТекущийПрогрессЧисло;
					КонецЕсли;
					ТекущийБаллЧисло = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(ПопыткаSCORMАктивности.cmi.score.raw);
					Если ТекущийБаллЧисло > МаксимальныйБаллЭтойАктивности Тогда
						МаксимальныйБаллЭтойАктивности = ТекущийБаллЧисло;
					КонецЕсли;
				КонецЦикла;
				
				ПрогрессЭлементовSCORM = ПрогрессЭлементовSCORM + ПрогрессЭтойАктивности;
				РеальныйБаллSCORM = РеальныйБаллSCORM + МаксимальныйБаллЭтойАктивности;
				
			Иначе
				
				Если ДанныеАктивности.complete Тогда
					ПрогрессЭлементовSCORM = ПрогрессЭлементовSCORM + 100;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если МаксимальныйПрогрессЭлементовSCORM > 0 Тогда
			ДанныеИзученияСтруктура.progress = Окр((ПрогрессЭлементовSCORM / МаксимальныйПрогрессЭлементовSCORM)*100);
		КонецЕсли;
		
		Если ДанныеИзученияСтруктура.progress = 100 Тогда
			 ДанныеИзученияСтруктура.complete = Истина;
		Иначе
			 ДанныеИзученияСтруктура.complete = Ложь;
		КонецЕсли;		

		Если МаксимальныйБаллSCORM > 0 Тогда
			ДанныеИзученияСтруктура.score = Окр((РеальныйБаллSCORM / МаксимальныйБаллSCORM)*100);
		КонецЕсли;
		
	КонецЕсли;
	
	
	
	
	// ИзученныеЭлектронныеКурсы	
	
	Движение = Движения.ИзученныеЭлектронныеКурсы.Добавить();	
	
	Движение.Период            = Дата;
	Движение.Учащийся          = Учащийся;
	Движение.Контекст          = Контекст;
	Движение.ЭлектронныйКурс   = ЭлектронныйКурс;
	Движение.Завершено         = ДанныеИзученияСтруктура.complete;	
	Движение.Результат         = ДанныеИзученияСтруктура.score;
	Движение.ИзученоВПроцентах = ДанныеИзученияСтруктура.progress; 
	Движение.ПроверяетсяПреподавателем = ПроверяетсяПреподавателем;
	Движение.ПроверенПреподавателем = ПроверенПреподавателем;
	
	
КонецПроцедуры

Функция ВосстановлениеЧтенияJSON(Свойство, Значение, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(Значение) Тогда
		Возврат Дата("00010101");
	Иначе		
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
КонецФункции

#КонецОбласти
	
#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли