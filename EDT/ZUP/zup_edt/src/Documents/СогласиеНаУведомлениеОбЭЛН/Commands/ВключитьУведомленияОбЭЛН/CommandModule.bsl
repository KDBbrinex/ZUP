#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(МассивСогласий, ПараметрыВыполненияКоманды)
	Если МассивСогласий.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	СЭДОФССКлиент.ИзменитьПодписку(Истина, МассивСогласий);
КонецПроцедуры

#КонецОбласти
