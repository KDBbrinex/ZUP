#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	УчетСтраховыхВзносов.СформироватьВозмещениеРасходовПоСоциальномуСтрахованию(Движения, Отказ, Организация, ДанныеДляПроведения());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеДляПроведения()
	
	РасчетыСФондами = Новый ТаблицаЗначений;
	РасчетыСФондами.Колонки.Добавить("Период");
	РасчетыСФондами.Колонки.Добавить("ВидОбязательногоСтрахованияСотрудников");
	РасчетыСФондами.Колонки.Добавить("ЭтоСтраховыеВзносы");
	РасчетыСФондами.Колонки.Добавить("Сумма");

	ДанныеДокумента = РасчетыСФондами.Добавить();
	ДанныеДокумента.Период = Дата;
	ДанныеДокумента.ВидОбязательногоСтрахованияСотрудников = ВидСтрахования;
	ДанныеДокумента.ЭтоСтраховыеВзносы = Истина;
	ДанныеДокумента.Сумма = СуммаВозмещения;
	
	Возврат РасчетыСФондами;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли