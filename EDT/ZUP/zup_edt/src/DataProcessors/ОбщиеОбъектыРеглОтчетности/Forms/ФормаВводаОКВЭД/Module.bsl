
#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОК(Команда)
	
	ОКВЭДПуст = Ложь;
	Если СтрЗаменить(ОКВЭД, " ", "") = ".." Тогда
		ОКВЭДПуст = Истина;
	КонецЕсли;

	// Проверим, чтобы первый разряд ОКВЭД был из цифр ХХ.
	Если (НЕ ОКВЭДПуст) И (СтрНайти(Лев(ОКВЭД, 2), " ") > 0) Тогда
		
		Сообщение = Новый СообщениеПользователю;

		Сообщение.Текст = НСтр("ru='В первом разряде кода ОКВЭД должны быть указаны два числовых символа.'");

		Сообщение.Сообщить();

		Возврат;
		
	КонецЕсли;
	
	Закрыть(ОКВЭД);
	
КонецПроцедуры // ОК()

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры // Отмена()

#КонецОбласти