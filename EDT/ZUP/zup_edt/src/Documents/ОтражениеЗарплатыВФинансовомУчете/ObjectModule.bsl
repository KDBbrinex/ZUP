#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ДанныеДляОтражения = Новый Структура;
	ДанныеДляОтражения.Вставить("НачисленнаяЗарплатаИВзносы", НачисленнаяЗарплатаИВзносы.Выгрузить());
	ДанныеДляОтражения.Вставить("НачисленныйНДФЛ", НачисленныйНДФЛ.Выгрузить());
	ДанныеДляОтражения.Вставить("УдержаннаяЗарплата", УдержаннаяЗарплата.Выгрузить());
	
	ОтражениеЗарплатыВФинансовомУчете.ЗарегистрироватьЗарплатуВФинансовомУчете(Движения, Отказ, ПериодРегистрации, ДанныеДляОтражения, Организация);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли