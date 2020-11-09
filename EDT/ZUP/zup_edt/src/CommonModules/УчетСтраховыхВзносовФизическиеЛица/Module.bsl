#Область СлужебныеПроцедурыИФункции

// Возвращает подготовленный запрос, формирующий временную таблицу с указанным именем.
// Временная таблица содержит поля Период, ФизическоеЛицо, ВидЗастрахованногоЛица.
//
// Параметры:
//		ТолькоРазрешенные
//		ОписательВременнойТаблицыОтборов - Структура, см. КадровыйУчет.ОписаниеВременнойТаблицыОтборовФизическихЛиц.
//		ПоляОтбораПериодическихДанных - Соответствие
//		ИмяВТСведенияОСтатусахЗастрахованныхЛиц - Строка, имя временной таблицы, созданной в результате выполнения запроса.
//
// ВозвращаемоеЗначение:
//		Запрос
//
Функция ЗапросВТСведенияОСтатусахЗастрахованныхЛиц(ТолькоРазрешенные, ОписательВременнойТаблицыОтборов, ПоляОтбораПериодическихДанных, ИмяВТСведенияОСтатусахЗастрахованныхЛиц = "ВТСведенияОСтатусахЗастрахованныхЛиц") Экспорт
	
	ОписаниеФильтра = ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра(
		ОписательВременнойТаблицыОтборов.ИмяВременнойТаблицыОтборовФизическихЛиц,
		"Период,ФизическоеЛицо");
	
	ОписаниеФильтра.СоответствиеИзмеренийРегистраИзмерениямФильтра.Вставить("Период", ОписательВременнойТаблицыОтборов.ИмяПоляПериод);
	ОписаниеФильтра.СоответствиеИзмеренийРегистраИзмерениямФильтра.Вставить("ФизическоеЛицо", ОписательВременнойТаблицыОтборов.ИмяПоляФизическоеЛицо);
	
	ПараметрыПостроения = ЗарплатаКадрыОбщиеНаборыДанных.ПараметрыПостроенияДляСоздатьВТИмяРегистраСрез();
	
	ПоляОтбора = Неопределено;
	Если ПоляОтбораПериодическихДанных <> Неопределено Тогда
		ПоляОтбораПериодическихДанных.Свойство("СтатусыЗастрахованныхФизическихЛиц", ПоляОтбора);
	КонецЕсли;
	
	ПараметрыПостроения.Отборы = ПоляОтбора;
	ПараметрыПостроения.СоответствиеПсевдонимовПолейСКД.Вставить("ВидЗастрахованногоЛица", "ВидЗастрахованногоЛицаРегистра");
	
	ЗапросВТИмяРегистраСрез = ЗарплатаКадрыОбщиеНаборыДанных.ЗапросВТИмяРегистраСрез(
		"СтатусыЗастрахованныхФизическихЛиц",
		ТолькоРазрешенные,
		ОписаниеФильтра,
		ПараметрыПостроения,
		Истина);
	 
	КадровыйУчет.УстановитьПутьКПолюФизическоеЛицо(ЗапросВТИмяРегистраСрез.Текст, "ИзмеренияДаты", ОписательВременнойТаблицыОтборов.ИмяПоляФизическоеЛицо);
	
	ТекстЗапросаДанных =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ТаблицаОтборов.Период КАК Период,
		|	ПредварительныеСведенияОСтатусахЗастрахованныхЛиц.ПериодЗаписи КАК ПериодЗаписи,
		|	ТаблицаОтборов.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ВЫБОР
		|		КОГДА ЕСТЬNULL(ПредварительныеСведенияОСтатусахЗастрахованныхЛиц.ВидЗастрахованногоЛица, ЗНАЧЕНИЕ(Перечисление.ВидыЗастрахованныхЛицОбязательногоСтрахования.ПустаяСсылка)) = ЗНАЧЕНИЕ(Перечисление.ВидыЗастрахованныхЛицОбязательногоСтрахования.ПустаяСсылка)
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыЗастрахованныхЛицОбязательногоСтрахования.ГражданеРФ)
		|		ИНАЧЕ ПредварительныеСведенияОСтатусахЗастрахованныхЛиц.ВидЗастрахованногоЛица
		|	КОНЕЦ КАК ВидЗастрахованногоЛица
		|ПОМЕСТИТЬ ВТСведенияОСтатусахЗастрахованныхЛиц
		|ИЗ
		|	ВТОтборовФизическихЛиц КАК ТаблицаОтборов
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТСтатусыЗастрахованныхФизическихЛицСрезПоследних КАК ПредварительныеСведенияОСтатусахЗастрахованныхЛиц
		|		ПО ТаблицаОтборов.Период = ПредварительныеСведенияОСтатусахЗастрахованныхЛиц.Период
		|			И ТаблицаОтборов.ФизическоеЛицо = ПредварительныеСведенияОСтатусахЗастрахованныхЛиц.ФизическоеЛицо
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТСтатусыЗастрахованныхФизическихЛицСрезПоследних";
		
	ТекстЗапросаДанных = СтрЗаменить(ТекстЗапросаДанных, "ВТОтборовФизическихЛиц", ОписательВременнойТаблицыОтборов.ИмяВременнойТаблицыОтборовФизическихЛиц);
	ТекстЗапросаДанных = СтрЗаменить(ТекстЗапросаДанных, "ТаблицаОтборов.Период", "ТаблицаОтборов." + ОписательВременнойТаблицыОтборов.ИмяПоляПериод);
	КадровыйУчет.УстановитьВТекстеЗапросаИмяПоляФизическоеЛицо(ТекстЗапросаДанных, "ТаблицаОтборов.ФизическоеЛицо", ОписательВременнойТаблицыОтборов.ИмяПоляФизическоеЛицо);
	ТекстЗапросаДанных = СтрЗаменить(ТекстЗапросаДанных, "ВТСведенияОСтатусахЗастрахованныхЛиц", ИмяВТСведенияОСтатусахЗастрахованныхЛиц);
	
	ЗарплатаКадрыОбщиеНаборыДанных.УстановитьВыборкуТолькоРазрешенныхДанных(ТекстЗапросаДанных, ТолькоРазрешенные);
	
	ЗапросВТИмяРегистраСрез.Текст = 
		ЗапросВТИмяРегистраСрез.Текст
		+ ЗарплатаКадрыОбщиеНаборыДанных.РазделительЗапросов()
		+ ТекстЗапросаДанных;
		
	Возврат ЗапросВТИмяРегистраСрез;
	
КонецФункции

// Сведения о статусах застрахованных физических лиц.

Функция ДобавитьПолеСведенийОСтатусахЗастрахованныхЛиц(ИмяПоля, ТекстыОписанияПолей, ИсточникиДанных) Экспорт
	
	ДобавленоПолеСведений = Ложь;
	Если НеобходимыСведенияОСтатусахЗастрахованныхЛиц(ИмяПоля) Тогда
		
		ДобавленоПолеСведений = Истина;
		ИсточникиДанных.Вставить("СведенияОСтатусахЗастрахованныхЛиц", Истина);
		
		ПутьКДанным = ПутьКДаннымСведенийОСтатусахЗастрахованныхЛиц(ИмяПоля);
		ТекстыОписанияПолей.Добавить(ПутьКДанным + " КАК " + ИмяПоля);
		
	КонецЕсли;
	
	Возврат ДобавленоПолеСведений;
	
КонецФункции

Процедура ДобавитьТекстЗапросаВТСведенияОСтатусахЗастрахованныхЛиц(Запрос, ТолькоРазрешенные, ОписательВременнойТаблицыОтборов, ПоляОтбораПериодическихДанных, ИсточникиДанных) Экспорт
	
	Если ИсточникиДанных.Получить("СведенияОСтатусахЗастрахованныхЛиц") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗапросВТ = ЗапросВТСведенияОСтатусахЗастрахованныхЛиц(ТолькоРазрешенные, ОписательВременнойТаблицыОтборов, ПоляОтбораПериодическихДанных);
	
	ЗарплатаКадрыОбщиеНаборыДанных.СкопироватьПараметрыЗапроса(Запрос, ЗапросВТ);
	
	ЧастиЗапроса = Новый Массив;
	ЧастиЗапроса.Добавить(ЗапросВТ.Текст);
	ЧастиЗапроса.Добавить(ЗарплатаКадрыОбщиеНаборыДанных.РазделительЗапросов());
	ЧастиЗапроса.Добавить(Запрос.Текст);
	
	ЧастиЗапроса.Добавить(
		"	{ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияОСтатусахЗастрахованныхЛиц КАК СтатусыЗастрахованныхЛиц
		|	ПО " + КадровыйУчет.ПутьКПолюФизическоеЛицо("ТаблицаОтборов", ОписательВременнойТаблицыОтборов.ИмяПоляФизическоеЛицо) + " = СтатусыЗастрахованныхЛиц.ФизическоеЛицо
		|		И ТаблицаОтборов." + ОписательВременнойТаблицыОтборов.ИмяПоляПериод + " = СтатусыЗастрахованныхЛиц.Период}");
	
	Запрос.Текст = СтрСоединить(ЧастиЗапроса, Символы.ПС);
	
	КадровыйУчет.ДобавитьВКоллекциюИмяКадровыхДанных(ИсточникиДанных, "ВТКУничтожению", "ВТСведенияОСтатусахЗастрахованныхЛиц");
	
КонецПроцедуры

Функция НеобходимыСведенияОСтатусахЗастрахованныхЛиц(Знач ИмяПоля) Экспорт
	
	Возврат ВРег(ИмяПоля) = ВРег("ВидЗастрахованногоЛицаПериодРегистрации")
		Или ВРег(ИмяПоля) = ВРег("ВидЗастрахованногоЛица");
	
КонецФункции

Функция ДобавитьКритерийПоискаПоСведениямОСтатусахЗастрахованныхЛиц(КритерииПоиска, УсловиеПоиска) Экспорт
	
	КритерийДобавлен = Ложь;
	Если НеобходимыСведенияОСтатусахЗастрахованныхЛиц(УсловиеПоиска.ЛевоеЗначение) Тогда
		
		ИмяПоля = ВРег(УсловиеПоиска.ЛевоеЗначение);
		Если ИмяПоля = ВРег("ВидЗастрахованногоЛицаПериодРегистрации") Тогда
			УсловиеПоиска.ЛевоеЗначение = "Период";
		
		КонецЕсли;
		
		КадровыйУчет.ДобавитьКритерийПоискаСотрудников(КритерииПоиска, "РегистрСведений.СтатусыЗастрахованныхФизическихЛиц", УсловиеПоиска);
		КритерийДобавлен = Истина;
		
	КонецЕсли;
	
	Возврат КритерийДобавлен;
	
КонецФункции

Функция ПутьКДаннымСведенийОСтатусахЗастрахованныхЛиц(Знач ИмяПоля)
	
	ИмяПоляВВерхнемРегистре = ВРег(ИмяПоля);
	
	ПутьКДанным = "";
	Если ИмяПоляВВерхнемРегистре = ВРег("ВидЗастрахованногоЛицаПериодРегистрации") Тогда
		ПутьКДанным = "	СтатусыЗастрахованныхЛиц.ПериодЗаписи";
	Иначе
		ПутьКДанным = "	СтатусыЗастрахованныхЛиц." + ИмяПоля;
	КонецЕсли;
	
	Возврат ПутьКДанным;
	
КонецФункции

Процедура ЗаполнитьПоляПредставленийКадровыхДанныхФизическихЛиц(ДополнительныеПоляПредставлений, ПутьКПолямЛичныхДанных) Экспорт
	
	ОписаниеПоля = ДополнительныеПоляПредставлений.Добавить();
	ОписаниеПоля.ИмяПоля = "ВидЗастрахованногоЛица";
	ОписаниеПоля.ПустоеЗначениеНаЯзыкеЗапросов = "ЗНАЧЕНИЕ(Перечисление.ВидыЗастрахованныхЛицОбязательногоСтрахования.ПустаяСсылка)";
	ОписаниеПоля.ПутьПоляСКД = ПутьКПолямЛичныхДанных + ".СтатусЗастрахованногоЛица";
	
	ОписаниеПоля = ДополнительныеПоляПредставлений.Добавить();
	ОписаниеПоля.ИмяПоля = "ВидЗастрахованногоЛицаПериодРегистрации";
	ОписаниеПоля.ПустоеЗначениеНаЯзыкеЗапросов = "ДАТАВРЕМЯ(1, 1, 1)";
	ОписаниеПоля.ПутьПоляСКД = ПутьКПолямЛичныхДанных + ".СтатусЗастрахованногоЛицаДатаУстановки";
	
КонецПроцедуры

#КонецОбласти
