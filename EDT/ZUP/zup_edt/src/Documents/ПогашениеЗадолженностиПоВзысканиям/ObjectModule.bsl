#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СтруктураВидовУчета = ПроведениеРасширенныйСервер.СтруктураВидовУчета();
	ПроведениеРасширенныйСервер.ПодготовитьНаборыЗаписейКРегистрацииДвиженийПоВидамУчета(РежимПроведения, Ссылка, СтруктураВидовУчета, Неопределено, Движения, ЭтотОбъект, Отказ);
	
	ДанныеДляПроведения = ДанныеДляПроведения();
	
	РасчетЗарплатыРасширенный.СформироватьЗадолженностьПоУдержаниямФизическихЛиц(Движения, ДанныеДляПроведения.ЗадолженностьПоУдержаниям);
	
	ПроведениеРасширенныйСервер.ЗаписьДвиженийПоУчетам(Движения, СтруктураВидовУчета);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеДляПроведения()
	
	ДанныеДляПроведения = Новый Структура;
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПогашениеЗадолженностиПоВзысканиям.МесяцНачисления КАК Период,
	               |	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	               |	ПогашениеЗадолженностиПоВзысканиям.Организация КАК Организация,
	               |	ПогашениеЗадолженностиПоВзысканиям.ФизическоеЛицо КАК ФизическоеЛицо,
	               |	ПогашениеЗадолженностиПоВзысканиям.Удержание КАК Удержание,
	               |	ПогашениеЗадолженностиПоВзысканиям.ДокументОснование КАК ДокументОснование,
	               |	ПогашениеЗадолженностиПоВзысканиям.Сумма КАК Сумма,
	               |	ИСТИНА КАК ПогашениеЗадолженности
	               |ИЗ
	               |	Документ.ПогашениеЗадолженностиПоВзысканиям КАК ПогашениеЗадолженностиПоВзысканиям
	               |ГДЕ
	               |	ПогашениеЗадолженностиПоВзысканиям.Ссылка = &Ссылка";
				   
	РезультатЗапроса = Запрос.Выполнить();
	
	ДанныеДляПроведения.Вставить("ЗадолженностьПоУдержаниям", РезультатЗапроса.Выгрузить());
	
	Возврат ДанныеДляПроведения;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли