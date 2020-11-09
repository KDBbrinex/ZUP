
#Область СлужебныеПроцедурыИФункции

Функция HeadHunter() Экспорт
	
	Возврат ПредопределенноеЗначение("Справочник.ИсточникиИнформацииОКандидатах.HeadHunter");
	
КонецФункции

Функция SuperJob() Экспорт
	
	Возврат ПредопределенноеЗначение("Справочник.ИсточникиИнформацииОКандидатах.SuperJob");
	
КонецФункции

Функция Rabota() Экспорт
	
	Возврат ПредопределенноеЗначение("Справочник.ИсточникиИнформацииОКандидатах.Rabota");
	
КонецФункции

Функция Zarplata() Экспорт
	
	Возврат ПредопределенноеЗначение("Справочник.ИсточникиИнформацииОКандидатах.Zarplata");
	
КонецФункции

Функция СоответствиеПоФиксированномуСоответствию(ФиксСоответствие) Экспорт
	
	Возврат Новый Соответствие(ФиксСоответствие);

КонецФункции

Функция НайтиВСтроке(СтрокаДляПоиска, ИскомаяСтрока, НаправлениеПоискаЧисло = 1) Экспорт
	
	Возврат СтрНайти(СтрокаДляПоиска, ИскомаяСтрока, ?(НаправлениеПоискаЧисло = 1, НаправлениеПоиска.СНачала, НаправлениеПоиска.СКонца));
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуHeadHunter(Идентификатор) Экспорт 
	
	ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ПустаяСсылка");
	
	Если Идентификатор = "higher" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразование");
	ИначеЕсли Идентификатор = "unfinished_higher" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	ИначеЕсли Идентификатор = "special_secondary" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПрофессиональноеОбразование");
	ИначеЕсли Идентификатор = "secondary" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПолноеОбщееОбразование");
	ИначеЕсли Идентификатор = "bachelor" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеБакалавриат");
	ИначеЕсли Идентификатор = "master" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеСпециалитетМагистратура");
	ИначеЕсли Идентификатор = "candidate" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.АспирантураОрдинатураАдъюнктура");
	ИначеЕсли Идентификатор = "doctor" Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.Докторантура");
	КонецЕсли;

	Возврат ВидОбразования;
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуRabota(Идентификатор) Экспорт 
	
	ДанныеОбразования = Новый Структура("ВидОбразования, ВидПослевузовскогоОбразования, ВидДополнительногоОбучения");
	ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ПустаяСсылка");
	
	Если (Идентификатор = 1
		Или Идентификатор = 5) Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПолноеОбщееОбразование");
	ИначеЕсли (Идентификатор = 2
		Или Идентификатор = 6) Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПрофессиональноеОбразование");
	ИначеЕсли (Идентификатор = 3
		Или Идентификатор = 7) Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	ИначеЕсли (Идентификатор = 4
		Или Идентификатор = 12) Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразование");
	ИначеЕсли (Идентификатор = 8
		Или Идентификатор = 9) Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеСпециалитетМагистратура");
	ИначеЕсли Идентификатор = 10 Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ДополнительноеПрофессиональноеОбразование");
		ДанныеОбразования.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.ПовышениеКвалификации");
	ИначеЕсли Идентификатор = 11 Тогда
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ДополнительноеПрофессиональноеОбразование");
		ДанныеОбразования.ВидДополнительногоОбучения = ПредопределенноеЗначение("Перечисление.ВидыПрофессиональнойПодготовки.Переподготовка");
	ИначеЕсли Идентификатор = 13 Тогда 
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеПодготовкаКадровВысшейКвалификации");
		ДанныеОбразования.ВидПослевузовскогоОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.Докторантура");
	ИначеЕсли Идентификатор = 14 Тогда 
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеБакалавриат");
	ИначеЕсли Идентификатор = 15 Тогда 
		ДанныеОбразования.ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеПодготовкаКадровВысшейКвалификации");
		ДанныеОбразования.ВидПослевузовскогоОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.АспирантураОрдинатураАдъюнктура");
	КонецЕсли;
	
	Возврат ДанныеОбразования;
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуSuperJob(Идентификатор) Экспорт
	
	ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ПустаяСсылка");
	
	Если Идентификатор = 2 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразование");
	ИначеЕсли Идентификатор = 3 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	ИначеЕсли Идентификатор = 4 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПрофессиональноеОбразование");
	ИначеЕсли Идентификатор = 5 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПолноеОбщееОбразование");
	ИначеЕсли Идентификатор = 6 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ОсновноеОбщееОбразование");
	ИначеЕсли Идентификатор = 7 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеБакалавриат");
	ИначеЕсли Идентификатор = 8 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразованиеСпециалитетМагистратура");
	ИначеЕсли Идентификатор = 9 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.АспирантураОрдинатураАдъюнктура");
	ИначеЕсли Идентификатор = 10 Тогда
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.Докторантура");
	КонецЕсли;

	Возврат ВидОбразования;
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуZarplata(Идентификатор) Экспорт
	
	ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ПустаяСсылка");
	Если Идентификатор = 388 Тогда // неполное среднее
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееОбщееОбразование");
	ИначеЕсли Идентификатор = 389 Тогда // среднее
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПолноеОбщееОбразование");
	ИначеЕсли Идентификатор = 390 Тогда // средне-специальное
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПрофессиональноеОбразование");
	ИначеЕсли Идентификатор = 391 Тогда // неполное высшее
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	ИначеЕсли Идентификатор = 392 Тогда // высшее
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразование");
	ИначеЕсли Идентификатор = 393 Тогда // два и более высших
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.ВысшееОбразование");
	ИначеЕсли Идентификатор = 3008 Тогда // студент очник
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	ИначеЕсли Идентификатор = 3028 Тогда // студент заочник
		ВидОбразования = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.НеполноеВысшееОбразование");
	КонецЕсли;
	
	Возврат ВидОбразования;
	
КонецФункции

Функция СреднееПолноеОбщееОбразование() Экспорт
	
	Возврат ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц.СреднееПолноеОбщееОбразование");

КонецФункции 

Функция МужскойПол() Экспорт
	
	Возврат ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Мужской");	
	
КонецФункции

Функция ЖенскийПол() Экспорт
	
	Возврат ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Женский");
	
КонецФункции

Функция ИмяСправочникаКандидатов() Экспорт
	
	Возврат "Кандидаты";
	
КонецФункции

Функция УникальноеИмяРеквизита() Экспорт
	
	Возврат ЗарплатаКадрыРасширенныйКлиентСервер.УникальноеИмяРеквизита();
	
КонецФункции

Функция ГруппаКнопокДляЗагрузкиССайта(Форма) Экспорт
	
	Возврат Форма.Элементы.КоманднаяПанельФормы.ПодчиненныеЭлементы.ФормаЗагрузить;
	
КонецФункции

#КонецОбласти







