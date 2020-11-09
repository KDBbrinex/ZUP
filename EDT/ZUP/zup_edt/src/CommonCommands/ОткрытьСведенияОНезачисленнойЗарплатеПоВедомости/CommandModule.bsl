#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	НезачислениеПоВедомости = НезачислениеПоВедомости(ПараметрКоманды);
	Если ЗначениеЗаполнено(НезачислениеПоВедомости) Тогда
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ключ", НезачислениеПоВедомости);
		ОткрытьФорму(
			"Документ.СведенияОНезачисленнойЗарплате.ФормаОбъекта", 
			ПараметрыФормы, 
			ПараметрыВыполненияКоманды.Источник, 
			ПараметрыВыполненияКоманды.Уникальность, 
			ПараметрыВыполненияКоманды.Окно); 
	Иначе	
		ТекстСообщения = НСтр("ru = 'По ведомости нет доступных сведений о незачисленной зарплате'");
		ВызватьИсключение ТекстСообщения
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция НезачислениеПоВедомости(Ведомость)
	Возврат Документы.СведенияОНезачисленнойЗарплате.НайтиПоВедомости(Ведомость)
КонецФункции	

#КонецОбласти
