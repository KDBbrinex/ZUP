#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ДатаУвольнения = ТекущаяДатаСеанса();
	
	АдаптацияУвольнение.ЗаполнитьПоСотруднику(ЭтотОбъект, ДанныеЗаполнения);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ОхранаТруда.МедицинскиеОсмотры") Тогда
		МодульМедицинскиеОсмотры = ОбщегоНазначения.ОбщийМодуль("МедицинскиеОсмотры");
		МодульМедицинскиеОсмотры.ЗаполнитьУвольнениеПоЗаключениюМедицинскогоОсмотра(ЭтотОбъект, ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	// Проведение документа
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ДанныеДляПроведения = ДанныеДляПроведения();
	
	АдаптацияУвольнение.СформироватьДвиженияМероприятияАдаптацииУвольненияПоДокументу(Движения, ДанныеДляПроведения.ДанныеМероприятийАдаптацииУвольнения);
	АдаптацияУвольнение.ЗарегистрироватьДокументДляОбновленияЗаданийАдаптацииУвольнения(Движения);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаУвольнения, "Объект.ДатаУвольнения", Отказ, НСтр("ru='Дата увольнения'"), , , Ложь);
	
	АдаптацияУвольнение.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты)
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	АдаптацияУвольнение.ОбработкаУдаленияПроведения(ЭтотОбъект, Отказ);
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	АдаптацияУвольнение.ПриЗаписи(ЭтотОбъект, Отказ);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ОхранаТруда.МедицинскиеОсмотры") Тогда
		МодульМедицинскиеОсмотры = ОбщегоНазначения.ОбщийМодуль("МедицинскиеОсмотры");
		МодульМедицинскиеОсмотры.ПриЗаписиДокументаОтстранения(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеДляПроведения()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = 
	"ВЫБРАТЬ 
	|	Увольнение.Сотрудник КАК Сотрудник,
	|	Увольнение.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Мероприятия.Мероприятие,
	|	Мероприятия.ДатаНачала,
	|	Мероприятия.ДатаОкончания,
	|	Мероприятия.Исполнитель
	|ИЗ
	|	Документ.РешениеОбУвольнении.МероприятияАдаптацииУвольнения КАК Мероприятия
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РешениеОбУвольнении КАК Увольнение
	|		ПО Мероприятия.Ссылка = Увольнение.Ссылка
	|ГДЕ
	|	Мероприятия.Ссылка = &Ссылка";
	
	ДанныеМероприятий = Запрос.Выполнить().Выгрузить();
	ДанныеМероприятий.Колонки.Добавить("ДокументОснование", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.СобытияАдаптацииУвольнения.Тип));
	ДанныеМероприятий.ЗаполнитьЗначения(Ссылка, "ДокументОснование");
	
	ДанныеДляПроведения = Новый Структура;
	ДанныеДляПроведения.Вставить("ДанныеМероприятийАдаптацииУвольнения", ДанныеМероприятий);
	
	Возврат ДанныеДляПроведения;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли