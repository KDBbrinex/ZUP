#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если ДанныеЗаполнения.Свойство("Действие") Тогда 
			Если ДанныеЗаполнения.Действие = "Исправить" Тогда
				
				ИсправлениеДокументовЗарплатаКадры.СкопироватьДокумент(ЭтотОбъект, 
						ДанныеЗаполнения.Ссылка, 
						"ПерерасчетВыполнен",
						"Начисления,НачисленияПерерасчет,Показатели,РаспределениеРезультатовНачислений");
				
				ИсправленныйДокумент = ДанныеЗаполнения.Ссылка;
				ЗарплатаКадрыРасширенный.ПриКопированииМногофункциональногоДокумента(ЭтотОбъект);
			ИначеЕсли ДанныеЗаполнения.Действие = "Заполнить" Тогда
				ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ЗарплатаКадрыРасширенный.ОбработкаЗаполненияМногофункциональногоДокумента(ЭтотОбъект, ДанныеЗаполнения, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Документы.ОтпускБезСохраненияОплатыСписком.ПровестиПоУчетам(Ссылка, РежимПроведения, Отказ, Неопределено, Движения, ЭтотОбъект, ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ОтпускаСотрудников", Сотрудники.Выгрузить());
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОтпускаСотрудниковСотрудники.Сотрудник,
	|	ОтпускаСотрудниковСотрудники.НомерСтроки,
	|	ОтпускаСотрудниковСотрудники.ДатаНачала,
	|	ОтпускаСотрудниковСотрудники.ДатаОкончания
	|ПОМЕСТИТЬ ВТОтпускаСотрудников
	|ИЗ
	|	&ОтпускаСотрудников КАК ОтпускаСотрудниковСотрудники
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтпускаСотрудников.Сотрудник,
	|	ОтпускаСотрудников.НомерСтроки
	|ПОМЕСТИТЬ ВТСтрокиСНекорректноЗаполненнымПериодомПредоставленияОтпуска
	|ИЗ
	|	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	|ГДЕ
	|	ОтпускаСотрудников.ДатаНачала > ОтпускаСотрудников.ДатаОкончания
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтпускаСотрудников.Сотрудник,
	|	МАКСИМУМ(ОтпускаСотрудниковДругие.НомерСтроки) КАК НомерСтроки
	|ПОМЕСТИТЬ ВТПересекаютсяПериодыОтпусков
	|ИЗ
	|	ВТОтпускаСотрудников КАК ОтпускаСотрудников
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТОтпускаСотрудников КАК ОтпускаСотрудниковДругие
	|		ПО ОтпускаСотрудников.Сотрудник = ОтпускаСотрудниковДругие.Сотрудник
	|			И ОтпускаСотрудников.НомерСтроки <> ОтпускаСотрудниковДругие.НомерСтроки
	|			И ОтпускаСотрудников.ДатаОкончания >= ОтпускаСотрудниковДругие.ДатаНачала
	|			И ОтпускаСотрудников.ДатаОкончания <= ОтпускаСотрудниковДругие.ДатаОкончания
	|			И (ОтпускаСотрудников.ДатаНачала <> ДАТАВРЕМЯ(1, 1, 1))
	|			И (ОтпускаСотрудников.ДатаОкончания <> ДАТАВРЕМЯ(1, 1, 1))
	|ГДЕ
	|	НЕ ОтпускаСотрудниковДругие.НомерСтроки ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ОтпускаСотрудников.Сотрудник
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПересекаютсяПериодыОтпусков.Сотрудник,
	|	ПересекаютсяПериодыОтпусков.НомерСтроки КАК НомерСтроки,
	|	ИСТИНА КАК ПересекаютсяПериоды,
	|	ЛОЖЬ КАК НекорректныйПериодПредоставления
	|ПОМЕСТИТЬ ВТСводный
	|ИЗ
	|	ВТПересекаютсяПериодыОтпусков КАК ПересекаютсяПериодыОтпусков
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	СтрокиСНекорректноЗаполненнымПериодомПредоставленияОтпуска.Сотрудник,
	|	СтрокиСНекорректноЗаполненнымПериодомПредоставленияОтпуска.НомерСтроки,
	|	ЛОЖЬ,
	|	ИСТИНА
	|ИЗ
	|	ВТСтрокиСНекорректноЗаполненнымПериодомПредоставленияОтпуска КАК СтрокиСНекорректноЗаполненнымПериодомПредоставленияОтпуска
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Сводный.Сотрудник,
	|	Сводный.НомерСтроки КАК НомерСтроки,
	|	МАКСИМУМ(Сводный.ПересекаютсяПериоды) КАК ПересекаютсяПериоды,
	|	МАКСИМУМ(Сводный.НекорректныйПериодПредоставления) КАК НекорректныйПериодПредоставления
	|ИЗ
	|	ВТСводный КАК Сводный
	|
	|СГРУППИРОВАТЬ ПО
	|	Сводный.Сотрудник,
	|	Сводный.НомерСтроки
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			Если Выборка.НекорректныйПериодПредоставления Тогда
				ТекстСообщения = ?(ПустаяСтрока(ТекстСообщения), "", ТекстСообщения +", ") +
					НСтр("ru='некорректно задан период предоставления отпуска'");
			КонецЕсли;
			
			Если Выборка.ПересекаютсяПериоды Тогда
				ТекстСообщения = ?(ПустаяСтрока(ТекстСообщения), "", ТекстСообщения +", ") +
					НСтр("ru='пересекается период нахождения в отпуске'");
			КонецЕсли;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='По сотруднику %1'"),
				Выборка.Сотрудник)
				+ " " + ТекстСообщения;
			
			ОбщегоНазначения.СообщитьПользователю(
				ТекстСообщения,
				,
				"Сотрудники[" + (Выборка.НомерСтроки - 1) + "].Сотрудник",
				"Объект",
				Отказ);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Для каждого СтрокаСотрудника Из Сотрудники Цикл
		
		Если Не ЗначениеЗаполнено(СтрокаСотрудника.ДатаНачала)
				Или Не ЗначениеЗаполнено(СтрокаСотрудника.ДатаОкончания) Тогда
			
			Если Не ЗначениеЗаполнено(СтрокаСотрудника.ДатаНачала)
				И Не ЗначениеЗаполнено(СтрокаСотрудника.ДатаОкончания) Тогда
			
				ТекстСообщения = НСтр("ru='не задан период отпуска'");
				ИмяРеквизита = "ДатаНачала";
				
			Иначе
				
				ТекстСообщения = НСтр("ru='неверно задан период отпуска'");
				Если Не ЗначениеЗаполнено(СтрокаСотрудника.ДатаНачала) Тогда
					ИмяРеквизита = "ДатаНачала";
				Иначе
					ИмяРеквизита = "ДатаОкончания";
				КонецЕсли;
					
			КонецЕсли;
				
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='По сотруднику %1'"),СтрокаСотрудника.Сотрудник)
				+ " " + ТекстСообщения;
				
			ОбщегоНазначения.СообщитьПользователю(
				ТекстСообщения,
				,
				"Сотрудники[" + (СтрокаСотрудника.НомерСтроки - 1) + "]." + ИмяРеквизита,
				"Объект",
				Отказ);
				
		КонецЕсли;
			
	КонецЦикла;
		
	Документы.ОтпускБезСохраненияОплатыСписком.ПроверитьРаботающих(ЭтотОбъект, Отказ);
		
	Если ПолучитьФункциональнуюОпцию("ИспользоватьРасчетЗарплатыРасширенная") Тогда
		
		ИсправлениеДокументовЗарплатаКадры.ПроверитьЗаполнение(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);
		
		ЗарплатаКадрыРасширенный.ПроверитьУтверждениеДокумента(ЭтотОбъект, Отказ);
		
		Если Не ЗначениеЗаполнено(ВидРасчета) 
			И Не ПолучитьФункциональнуюОпцию("ВыбиратьВидНачисленияОтпускБезОплаты") Тогда
			
			ОбщегоНазначения.СообщитьПользователю(
				Документы.ОтпускБезСохраненияОплаты.ТекстСообщенияНеЗаполненВидРасчета(ВидОтпуска, Ложь),
				Ссылка,
				,
				,
				Отказ);
		КонецЕсли;
		
		Если ПерерасчетВыполнен И Не Отказ Тогда 
			
			// Проверка корректности распределения по источникам финансирования
			ИменаТаблицРаспределяемыхПоСтатьямФинансирования = "Начисления,НачисленияПерерасчет";
			
			ОтражениеЗарплатыВБухучетеРасширенный.ПроверитьРезультатыРаспределенияНачисленийУдержанийОбъекта(
				ЭтотОбъект, ИменаТаблицРаспределяемыхПоСтатьямФинансирования, Отказ);
				
			// Проверка корректности распределения по территориям и условиям труда
			ИменаТаблицРаспределенияПоТерриториямУсловиямТруда = "Начисления,НачисленияПерерасчет";
			
			РасчетЗарплатыРасширенный.ПроверитьРаспределениеПоТерриториямУсловиямТрудаДокумента(
				ЭтотОбъект, ИменаТаблицРаспределенияПоТерриториямУсловиямТруда, Отказ);
			
			ПроверитьПериодДействияНачислений(Отказ);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ПредставлениеПериода = ЗарплатаКадрыРасширенный.ПредставлениеПериодаРасчетногоДокумента(ПериодРегистрации);
	
	ЗарплатаКадрыРасширенный.ПередЗаписьюМногофункциональногоДокумента(ЭтотОбъект, Отказ, РежимЗаписи, РежимПроведения);
	РасчетЗарплатыРасширенный.ЗаполнитьИсходныйДокумент(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Если Не ОбъектКопирования.ДополнительныеСвойства.Свойство("МодификацияЗапрещена") Тогда
		ЗарплатаКадрыРасширенный.ПриКопированииМногофункциональногоДокумента(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьПериодДействияНачислений(Отказ)
	
	ПараметрыПроверкиПериодаДействия = РасчетЗарплатыРасширенный.ПараметрыПроверкиПериодаДействия();
	ПараметрыПроверкиПериодаДействия.Ссылка = Ссылка;
	ПроверяемыеКоллекции = Новый Массив;
	ПроверяемыеКоллекции.Добавить(РасчетЗарплатыРасширенный.ОписаниеКоллекцииДляПроверкиПериодаДействия("НачисленияПерерасчет", НСтр("ru='Перерасчет прошлого периода'")));
	РасчетЗарплатыРасширенный.ПроверитьПериодДействияВКоллекцияхНачислений(ЭтотОбъект, ПараметрыПроверкиПериодаДействия, ПроверяемыеКоллекции, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли