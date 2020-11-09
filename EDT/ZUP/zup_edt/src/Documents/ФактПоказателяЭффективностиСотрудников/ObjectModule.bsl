#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	СтрокаТаблицы = Таблица.Добавить();
	СтрокаТаблицы.ЗначениеДоступа = Подразделение;
	
	МассивФизическихЛиц = ФизическиеЛица.ВыгрузитьКолонку("ФизическоеЛицо");
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицуИзМассива(Таблица, МассивФизическихЛиц, "ЗначениеДоступа");
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ДанныеДляПроведения = Документы.ФактПоказателяЭффективностиСотрудников.ПолучитьДанныеДляПроведения(Ссылка);
	КлючевыеПоказателиЭффективности.СформироватьДвиженияФактическиеЗначенияПоказателейЭффективностиСотрудников(Движения, ДанныеДляПроведения.ФактСотрудников);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЭтоСуммируемыйПоказатель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Показатель, "Суммируемый");
	Если ЭтоСуммируемыйПоказатель = Истина Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаФактаСотрудников = РегистрыНакопления.ФактическиеЗначенияПоказателейЭффективностиСотрудников.ТаблицаИзмеренийПланаСотрудников();
	
	Для каждого СтрокаСотрудника Из Сотрудники Цикл
		НоваяСтрока = ТаблицаФактаСотрудников.Добавить();
		НоваяСтрока.ДатаНачала = НачалоМесяца(Период);
		НоваяСтрока.ДатаОкончания = КонецМесяца(Период);
		НоваяСтрока.Горизонт = Горизонт;
		НоваяСтрока.Сотрудник = СтрокаСотрудника.Сотрудник;
		НоваяСтрока.Показатель = Показатель;
	КонецЦикла; 
	
	ТаблицаВведенныхЗначений = КлючевыеПоказателиЭффективности.ВведенныеФактическиеЗначенияПоказателейСотрудников(ТаблицаФактаСотрудников, Ссылка);
	
	Для каждого СтрокаВведенныхЗначений Из ТаблицаВведенныхЗначений Цикл
		НайденныеСтроки = Сотрудники.НайтиСтроки(Новый Структура("Сотрудник", СтрокаВведенныхЗначений.Сотрудник));
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Для сотрудника %1 уже введено фактическое значение показателя %2.'"), СтрокаВведенныхЗначений.Сотрудник, Показатель);
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			ОбщегоНазначения.СообщитьПользователю(
				ТекстОшибки,
				ЭтотОбъект,
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("Сотрудники[%1].Сотрудник", Сотрудники.Индекс(НайденнаяСтрока)),, Отказ);
		КонецЦикла; 
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли