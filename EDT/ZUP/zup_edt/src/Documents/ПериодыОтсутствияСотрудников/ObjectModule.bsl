#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	СотрудникиПериоды = Новый Соответствие;
	Для Каждого СтрокаСотрудника Из Сотрудники Цикл
		
		ПериодыСотрудника = СотрудникиПериоды.Получить(СтрокаСотрудника.Сотрудник);
		Если ПериодыСотрудника = Неопределено Тогда
			
			ПериодыСотрудника = Новый Массив;
			СотрудникиПериоды.Вставить(СтрокаСотрудника.Сотрудник, ПериодыСотрудника);
			
		КонецЕсли;
		
		Для Каждого ПериодСотрудника Из ПериодыСотрудника Цикл
			
			Если СтрокаСотрудника.ДатаНачала >= ПериодСотрудника.ДатаНачала
				И СтрокаСотрудника.ДатаНачала <= ПериодСотрудника.ДатаОкончания
					Или СтрокаСотрудника.ДатаОкончания >= ПериодСотрудника.ДатаНачала
						И СтрокаСотрудника.ДатаОкончания <= ПериодСотрудника.ДатаОкончания
					Или СтрокаСотрудника.ДатаНачала < ПериодСотрудника.ДатаНачала
						И СтрокаСотрудника.ДатаОкончания > ПериодСотрудника.ДатаОкончания Тогда
				
				ОбщегоНазначения.СообщитьПользователю(
					СтрШаблон(НСтр("ru='По сотруднику %1 повторяется период в строке %2'"), СтрокаСотрудника.Сотрудник, СтрокаСотрудника.НомерСтроки),
					Ссылка, "Объект.Сотрудники[" + Формат(СтрокаСотрудника.НомерСтроки - 1, "ЧН=0; ЧГ=0") + "].Сотрудник", , Отказ);
				
			КонецЕсли;
			
		КонецЦикла;
		
		ПериодыСотрудника.Добавить(Новый Структура("ДатаНачала,ДатаОкончания", СтрокаСотрудника.ДатаНачала, СтрокаСотрудника.ДатаОкончания));
		
	КонецЦикла;
	
	Если Не Отказ Тогда
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("Регистратор", Ссылка);
		Запрос.УстановитьПараметр("Сотрудники", Сотрудники.Выгрузить());
		
		Запрос.Текст =
			"ВЫБРАТЬ
			|	Сотрудники.НомерСтроки КАК НомерСтроки,
			|	Сотрудники.Сотрудник КАК Сотрудник,
			|	Сотрудники.ДатаНачала КАК ДатаНачала,
			|	Сотрудники.ДатаОкончания КАК ДатаОкончания
			|ПОМЕСТИТЬ ВТСотрудники
			|ИЗ
			|	&Сотрудники КАК Сотрудники
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	Сотрудники.Сотрудник КАК Сотрудник,
			|	Сотрудники.ДатаНачала КАК ДатаНачала,
			|	Сотрудники.ДатаОкончания КАК ДатаОкончания,
			|	Сотрудники.НомерСтроки КАК НомерСтроки,
			|	ПериодыОтсутствияСотрудников.Регистратор КАК Регистратор,
			|	ПериодыОтсутствияСотрудников.ВидОтсутствия КАК ВидОтсутствия
			|ПОМЕСТИТЬ ВТКонфликты
			|ИЗ
			|	ВТСотрудники КАК Сотрудники
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПериодыОтсутствияСотрудников КАК ПериодыОтсутствияСотрудников
			|		ПО Сотрудники.Сотрудник = ПериодыОтсутствияСотрудников.Сотрудник
			|			И Сотрудники.ДатаНачала >= ПериодыОтсутствияСотрудников.Начало
			|			И Сотрудники.ДатаНачала <= ПериодыОтсутствияСотрудников.Окончание
			|			И (ПериодыОтсутствияСотрудников.Регистратор <> &Регистратор)
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	Сотрудники.Сотрудник,
			|	Сотрудники.ДатаНачала,
			|	Сотрудники.ДатаОкончания,
			|	Сотрудники.НомерСтроки,
			|	ПериодыОтсутствияСотрудников.Регистратор,
			|	ПериодыОтсутствияСотрудников.ВидОтсутствия
			|ИЗ
			|	ВТСотрудники КАК Сотрудники
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПериодыОтсутствияСотрудников КАК ПериодыОтсутствияСотрудников
			|		ПО Сотрудники.Сотрудник = ПериодыОтсутствияСотрудников.Сотрудник
			|			И Сотрудники.ДатаОкончания >= ПериодыОтсутствияСотрудников.Начало
			|			И Сотрудники.ДатаОкончания <= ПериодыОтсутствияСотрудников.Окончание
			|			И (ПериодыОтсутствияСотрудников.Регистратор <> &Регистратор)
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	Сотрудники.Сотрудник,
			|	Сотрудники.ДатаНачала,
			|	Сотрудники.ДатаОкончания,
			|	Сотрудники.НомерСтроки,
			|	ПериодыОтсутствияСотрудников.Регистратор,
			|	ПериодыОтсутствияСотрудников.ВидОтсутствия
			|ИЗ
			|	ВТСотрудники КАК Сотрудники
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПериодыОтсутствияСотрудников КАК ПериодыОтсутствияСотрудников
			|		ПО Сотрудники.Сотрудник = ПериодыОтсутствияСотрудников.Сотрудник
			|			И Сотрудники.ДатаНачала < ПериодыОтсутствияСотрудников.Начало
			|			И Сотрудники.ДатаОкончания > ПериодыОтсутствияСотрудников.Окончание
			|			И (ПериодыОтсутствияСотрудников.Регистратор <> &Регистратор)
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	Конфликты.Сотрудник КАК Сотрудник,
			|	Конфликты.ДатаНачала КАК ДатаНачала,
			|	Конфликты.ДатаОкончания КАК ДатаОкончания,
			|	Конфликты.НомерСтроки КАК НомерСтроки,
			|	МАКСИМУМ(Конфликты.Регистратор) КАК Регистратор
			|ПОМЕСТИТЬ ВТРегистраторы
			|ИЗ
			|	ВТКонфликты КАК Конфликты
			|
			|СГРУППИРОВАТЬ ПО
			|	Конфликты.Сотрудник,
			|	Конфликты.ДатаНачала,
			|	Конфликты.ДатаОкончания,
			|	Конфликты.НомерСтроки
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Регистраторы.Сотрудник КАК Сотрудник,
			|	Регистраторы.ДатаНачала КАК ДатаНачала,
			|	Регистраторы.ДатаОкончания КАК ДатаОкончания,
			|	Регистраторы.НомерСтроки КАК НомерСтроки,
			|	Регистраторы.Регистратор КАК Регистратор,
			|	Конфликты.ВидОтсутствия КАК ВидОтсутствия
			|ИЗ
			|	ВТРегистраторы КАК Регистраторы
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТКонфликты КАК Конфликты
			|		ПО Регистраторы.Сотрудник = Конфликты.Сотрудник
			|			И Регистраторы.ДатаНачала = Конфликты.ДатаНачала
			|			И Регистраторы.ДатаОкончания = Конфликты.ДатаОкончания
			|			И Регистраторы.Регистратор = Конфликты.Регистратор
			|
			|УПОРЯДОЧИТЬ ПО
			|	НомерСтроки,
			|	Сотрудник";
		
		РезультатЗапроса = Запрос.Выполнить();
		Если Не РезультатЗапроса.Пустой() Тогда
			
			Выборка = РезультатЗапроса.Выбрать();
			Пока Выборка.Следующий() Цикл
				
				ОбщегоНазначения.СообщитьПользователю(
					СтрШаблон(НСтр("ru='Строка %1 по сотруднику %2 противоречит периоду документа %3 (%4)'"),
						Выборка.НомерСтроки, Выборка.Сотрудник, Выборка.Регистратор, Выборка.ВидОтсутствия),
					Ссылка, "Объект.Сотрудники[" + Формат(Выборка.НомерСтроки - 1, "ЧН=0; ЧГ=0") + "].Сотрудник", , Отказ);
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ДанныеПроведения = ДанныеДляПроведения();
	
	ОтсутствияСотрудников.СформироватьДвиженияПериодыОтсутствияСотрудников(Движения, ДанныеПроведения.ПериодыОтсутствия);
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытий

Функция ДанныеДляПроведения()
	
	ДанныеПроведения = Новый Структура;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПериодыОтсутствияСотрудниковСотрудники.Ссылка.Организация КАК Организация,
		|	ПериодыОтсутствияСотрудниковСотрудники.Сотрудник КАК Сотрудник,
		|	ПериодыОтсутствияСотрудниковСотрудники.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ПериодыОтсутствияСотрудниковСотрудники.ДатаНачала КАК Начало,
		|	ПериодыОтсутствияСотрудниковСотрудники.ДатаОкончания КАК Окончание,
		|	ПериодыОтсутствияСотрудниковСотрудники.ВидОтсутствия КАК ВидОтсутствия,
		|	ПериодыОтсутствияСотрудниковСотрудники.ЧастьСмены КАК ЧастьСмены,
		|	ПериодыОтсутствияСотрудниковСотрудники.КоличествоЧасов КАК КоличествоЧасов
		|ИЗ
		|	Документ.ПериодыОтсутствияСотрудников.Сотрудники КАК ПериодыОтсутствияСотрудниковСотрудники
		|ГДЕ
		|	ПериодыОтсутствияСотрудниковСотрудники.Ссылка = &Ссылка";
	
	ДанныеПроведения.Вставить("ПериодыОтсутствия", Запрос.Выполнить().Выгрузить());
	
	Возврат ДанныеПроведения;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли