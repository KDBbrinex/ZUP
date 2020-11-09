#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	СтрокаТаблицы = Таблица.Добавить();
	СтрокаТаблицы.ЗначениеДоступа = Подразделение;
	
	СтрокаТаблицы = Таблица.Добавить();
	СтрокаТаблицы.ЗначениеДоступа = ФизическоеЛицо;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ДанныеДляПроведения = Документы.ПланПоказателейЭффективностиСотрудника.ПолучитьДанныеДляПроведения(Ссылка);
	КлючевыеПоказателиЭффективности.СформироватьДвиженияПлановыеЗначенияПоказателейЭффективностиСотрудников(Движения, ДанныеДляПроведения.ПланСотрудников);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ПоказателиСтрокой = КлючевыеПоказателиЭффективности.ПоказателиСтрокой(Показатели);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ПараметрыПоказатели = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(ДанныеЗаполнения, "Показатели");
	Если ПараметрыПоказатели <> Неопределено Тогда
		Для каждого Показатель Из ПараметрыПоказатели Цикл
			НоваяСтрока = Показатели.Добавить();
			НоваяСтрока.Показатель = Показатель;
		КонецЦикла; 
	КонецЕсли; 
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ТаблицаПланаСотрудников = РегистрыСведений.ПлановыеЗначенияПоказателейЭффективностиСотрудников.ТаблицаИзмеренийПланаСотрудников();
	
	Для каждого СтрокаПоказателя Из Показатели Цикл
		НоваяСтрока = ТаблицаПланаСотрудников.Добавить();
		НоваяСтрока.ПериодДействия = Период;
		НоваяСтрока.Сотрудник = Сотрудник;
		НоваяСтрока.Показатель = СтрокаПоказателя.Показатель;
	КонецЦикла; 
	
	ТаблицаВведенныхЗначений = КлючевыеПоказателиЭффективности.ВведенныеПлановыеЗначенияПоказателейСотрудников(ТаблицаПланаСотрудников, Ссылка);
	
	Для каждого СтрокаВведенныхЗначений Из ТаблицаВведенныхЗначений Цикл
		НайденныеСтроки = Показатели.НайтиСтроки(Новый Структура("Показатель", СтрокаВведенныхЗначений.Показатель));
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Для сотрудника %1 уже введено плановое значение показателя %2.'"), Сотрудник, СтрокаВведенныхЗначений.Показатель);
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			ОбщегоНазначения.СообщитьПользователю(
				ТекстОшибки,
				ЭтотОбъект,
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("Показатели[%1].Показатель", Показатели.Индекс(НайденнаяСтрока)),, Отказ);
		КонецЦикла; 
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли