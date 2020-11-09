
#Область СлужебныйПрограммныйИнтерфейс

// Возвращает Таблицу соответствия КодовДоходаНДФЛ, Категории начисления (для кода дохода 4800) и Категории дохода
// Если заполнен параметр КодДоходаНДФЛ тип СправочникСсылка.ВидыДоходовНДФЛ, то соответствие будет возвращено только
// для этого кода.
//
Функция СопоставлениеКодовИКатегорийДоходовНДФЛ(КодДоходаНДФЛ = Неопределено) Экспорт
	
	СоответствиеКодов = Новый ТаблицаЗначений;
	СоответствиеКодов.Колонки.Добавить("КодДохода", Новый ОписаниеТипов("СправочникСсылка.ВидыДоходовНДФЛ"));
	СоответствиеКодов.Колонки.Добавить("КатегорияДохода", Новый ОписаниеТипов("ПеречислениеСсылка.КатегорииДоходовНДФЛ"));
	СоответствиеКодов.Колонки.Добавить("КатегорияНачисления", Новый ОписаниеТипов("ПеречислениеСсылка.КатегорииНачисленийИНеоплаченногоВремени"));
	СоответствиеКодов.Колонки.Добавить("Порядок", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(1)));
	
	ДополнительныеДивиденды = ОбщегоНазначенияКлиентСервер.РазностьМассивов(Перечисления.КатегорииДоходовНДФЛ.Дивиденды(), ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Перечисления.КатегорииДоходовНДФЛ.Дивиденды));
	АвторскиеРоялти = Перечисления.КатегорииДоходовНДФЛ.АвторскиеРоялти();

	Запрос = Новый Запрос;
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ВидыДоходовНДФЛ.Ссылка КАК КодДохода,
	|	ВидыДоходовНДФЛ.КодПрименяемыйВНалоговойОтчетностиС2010Года КАК Код
	|ИЗ
	|	Справочник.ВидыДоходовНДФЛ КАК ВидыДоходовНДФЛ
	|ГДЕ
	|	&Условие";
	Если ЗначениеЗаполнено(КодДоходаНДФЛ) Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Условие", "ВидыДоходовНДФЛ.Ссылка = &Ссылка");
		Запрос.УстановитьПараметр("Ссылка", КодДоходаНДФЛ);
	Иначе
		Запрос.УстановитьПараметр("Условие", Истина);
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		КатегорияДохода = УчетНДФЛПовтИсп.КатегорияДоходаПоЕгоКоду(Выборка.КодДохода);
		
		Если Выборка.Код = "2002" Тогда
			Если КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ОплатаТруда Тогда
				ДополнительныеКатегории = Новый Массив;
				ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности);
				ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ДоходВНатуральнойФормеОтТрудовойДеятельности);
				УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода, ДополнительныеКатегории);
			Иначе // как прочие доходы от трудовой деятельности в денежной форме
				ДополнительныеКатегории = Новый Массив;
				ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы);
				ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
				УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода, ДополнительныеКатегории);
			КонецЕсли;
		ИначеЕсли КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ОплатаТруда Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода);
		ИначеЕсли КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.Дивиденды Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода, ДополнительныеДивиденды);
			
		// Оплата труда в натуральной форме
		ИначеЕсли КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ДоходВНатуральнойФормеОтТрудовойДеятельности Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода, Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
			
		// Прочие доходы от трудовой деятельности в денежной форме
		ИначеЕсли КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности Тогда
			ДополнительныеКатегории = Новый Массив;
			ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы);
			Если Выборка.Код = "2003"
				Или Выборка.Код = "2010" Тогда
				ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
			КонецЕсли;
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода, ДополнительныеКатегории);
			
		ИначеЕсли Выборка.Код = "2720" Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы,
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы);
											
		ИначеЕсли КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, КатегорияДохода);
			
		// ПрочиеДоходы
		ИначеЕсли Выборка.Код = "1011"
			Или Выборка.Код = "1110"
			Или Выборка.Код = "1537"
			Или Выборка.Код = "1538"
			Или Выборка.Код = "1551"
			Или Выборка.Код = "1552"
			Или Выборка.Код = "1300"
			Или Выборка.Код = "1301"
			Или Выборка.Код = "2210" Тогда
			
			ДополнительныеКатегории = Новый Массив;
			ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
			ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ДополнительныеКатегории, АвторскиеРоялти);
			
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы, 
											ДополнительныеКатегории);

		ИначеЕсли Выборка.Код = "2201"
			Или Выборка.Код = "2202"
			Или Выборка.Код = "2203"
			Или Выборка.Код = "2204"
			Или Выборка.Код = "2205"
			Или Выборка.Код = "2206"
			Или Выборка.Код = "2207"
			Или Выборка.Код = "2208"
			Или Выборка.Код = "2209" Тогда
			
			ДополнительныеКатегории = Новый Массив;
			ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности);
			ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ДополнительныеКатегории, АвторскиеРоялти);
			ДополнительныеКатегории.Добавить(Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
			
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы, 
											ДополнительныеКатегории);
			
		ИначеЕсли Выборка.Код = "2760" Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы,
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности);
			
		// код 4800 обрабатываем отдельно
		ИначеЕсли Выборка.Код = "4800" Тогда
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы,
											Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ПовременнаяОплатаТруда);
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы,
											Перечисления.КатегорииНачисленийИНеоплаченногоВремени.РайонныйКоэффициент);
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы,
											Перечисления.КатегорииНачисленийИНеоплаченногоВремени.СевернаяНадбавка);
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходыВДенежнойФормеОтТрудовойДеятельности, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы,
											Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаКомандировки);
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы,
											Перечисления.КатегорииНачисленийИНеоплаченногоВремени.Прочее);
			
		// все остальные
		Иначе
			УчетФактическиПолученныхДоходов.НовоеСоответствиеКодуДохода(СоответствиеКодов, Выборка.КодДохода, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеДоходы, 
											Перечисления.КатегорииДоходовНДФЛ.ПрочиеНатуральныеДоходы);
		КонецЕсли;
	КонецЦикла;
	
	Возврат СоответствиеКодов;
	
КонецФункции

// Регистрирует полученный доход "Начислятелей" на новую дату получения дохода
// Параметры:
//		Регистратор - ДокументСсылка - документ выплаты
//		МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - должен содержать временные таблицы 
//      	ВТСписокСотрудников, с данными о выплатах вида:
//				ФизическоеЛицо: должно быть непустым
//          	СуммаВыплаты.
//          	ДокументОснование, необязательная
//          	СтатьяФинансирования, необязательная
//          	СтатьяРасходов, необязательная
//          	СуммаНачисленная, необязательная
//          	СуммаВыплаченная, необязательная, 
//			Если колонки СуммаНачисленная, СуммаВыплаченная отсутствуют, возможная частичная выплата не будет учтена.
//		Движения - коллекция движений регистратора.
//		ДатаВыплаты - дата - новая дата получения дохода.
//		ДатаОперации - дата - дата, которой будет зарегистрировано движение.
//		Отказ - признак отказа от заполнения движений.
//
Процедура ЗарегистрироватьНовуюДатуПолученияДохода(Регистратор, Движения, МенеджерВременныхТаблиц, ДатаВыплаты, ДатаОперации, Отказ, Записывать = Ложь) Экспорт
	
	Если Отказ Или ДатаВыплаты < УчетФактическиПолученныхДоходов.ДатаНачалаИспользованияПодсистемы() Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицыКУдалению = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	Запрос.УстановитьПараметр("ДоляПолнойВыплаты", УчетНДФЛ.ДоляПолнойВыплаты());
	
	ПеренесенныхДоходы = Новый ТаблицаЗначений;
	ПеренесенныхДоходы.Колонки.Добавить("ФизическоеЛицо", Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"));
	ПеренесенныхДоходы.Колонки.Добавить("КатегорияДохода", Новый ОписаниеТипов("ПеречислениеСсылка.КатегорииДоходовНДФЛ"));
	ПеренесенныхДоходы.Колонки.Добавить("ДокументОснование", Метаданные.ОпределяемыеТипы.ДокументыОснованияНДФЛ.Тип);
	ПеренесенныхДоходы.Колонки.Добавить("СуммаДохода", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15,2)));
	ПеренесенныхДоходы.Колонки.Добавить("ОбщаяСуммаДохода", Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(15,2)));
	
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА КАК Поле1
	|ИЗ
	|	ВТСписокСотрудников КАК ДанныеВедомости
	|ГДЕ
	|	ДанныеВедомости.СуммаВыплаты < 0";
	Если Запрос.Выполнить().Пустой() Тогда
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДанныеВедомости.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование КАК ДокументОснование,
		|	ДанныеВедомости.СтатьяФинансирования КАК СтатьяФинансирования,
		|	ДанныеВедомости.СтатьяРасходов КАК СтатьяРасходов,
		|	СУММА(ДанныеВедомости.СуммаВыплаты) КАК СуммаВыплаты,
		|	СУММА(ДанныеВедомости.СуммаНачисленная) КАК СуммаНачисленная,
		|	СУММА(ДанныеВедомости.СуммаВыплаченная) КАК СуммаВыплаченная
		|ПОМЕСТИТЬ ВТДанныеДляОтбора
		|ИЗ
		|	ВТСписокСотрудников КАК ДанныеВедомости
		|ГДЕ
		|	ДанныеВедомости.ДокументОснование <> НЕОПРЕДЕЛЕНО
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомости.ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование,
		|	ДанныеВедомости.СтатьяФинансирования,
		|	ДанныеВедомости.СтатьяРасходов
		|
		|ИМЕЮЩИЕ
		|	СУММА(ДанныеВедомости.СуммаВыплаты) > 0";
		КолонкиРезультата = МенеджерВременныхТаблиц.Таблицы["ВТСписокСотрудников"].Колонки;
		Если КолонкиРезультата.Найти("ДокументОснование") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.ДокументОснование", "НЕОПРЕДЕЛЕНО") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СуммаНачисленная") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СуммаНачисленная", "0") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СуммаВыплаченная") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СуммаВыплаченная", "0") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СтатьяФинансирования") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СтатьяФинансирования", "НЕОПРЕДЕЛЕНО");
		КонецЕсли;
		Если КолонкиРезультата.Найти("СтатьяРасходов") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СтатьяРасходов", "НЕОПРЕДЕЛЕНО") 
		КонецЕсли;
		Запрос.Текст = ТекстЗапроса;
		
		ТаблицыКУдалению.Добавить("ВТДанныеДляОтбора");
	Иначе
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДанныеВедомости.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование КАК ДокументОснование
		|ПОМЕСТИТЬ ВТПоложительныеДоходы
		|ИЗ
		|	ВТСписокСотрудников КАК ДанныеВедомости
		|ГДЕ
		|	ДанныеВедомости.ДокументОснование <> НЕОПРЕДЕЛЕНО
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомости.ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование
		|
		|ИМЕЮЩИЕ
		|	СУММА(ДанныеВедомости.СуммаВыплаты) > 0";
		КолонкиРезультата = МенеджерВременныхТаблиц.Таблицы["ВТСписокСотрудников"].Колонки;
		Если КолонкиРезультата.Найти("ДокументОснование") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.ДокументОснование", "НЕОПРЕДЕЛЕНО") 
		КонецЕсли;
		Запрос.Текст = ТекстЗапроса;
		
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДанныеВедомости.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование КАК ДокументОснование,
		|	ДанныеВедомости.СтатьяФинансирования КАК СтатьяФинансирования,
		|	ДанныеВедомости.СтатьяРасходов КАК СтатьяРасходов,
		|	СУММА(ДанныеВедомости.СуммаВыплаты) КАК СуммаВыплаты,
		|	СУММА(ДанныеВедомости.СуммаНачисленная) КАК СуммаНачисленная,
		|	СУММА(ДанныеВедомости.СуммаВыплаченная) КАК СуммаВыплаченная
		|ПОМЕСТИТЬ ВТДанныеДляОтбора
		|ИЗ
		|	ВТСписокСотрудников КАК ДанныеВедомости
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПоложительныеДоходы КАК ПоложительныеДоходы
		|		ПО ДанныеВедомости.ФизическоеЛицо = ПоложительныеДоходы.ФизическоеЛицо
		|			И ДанныеВедомости.ДокументОснование = ПоложительныеДоходы.ДокументОснование
		|ГДЕ
		|	ДанныеВедомости.ДокументОснование <> НЕОПРЕДЕЛЕНО
		|	И ПоложительныеДоходы.ФизическоеЛицо ЕСТЬ НЕ NULL 
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомости.ФизическоеЛицо,
		|	ДанныеВедомости.ДокументОснование,
		|	ДанныеВедомости.СтатьяФинансирования,
		|	ДанныеВедомости.СтатьяРасходов
		|
		|ИМЕЮЩИЕ
		|	СУММА(ДанныеВедомости.СуммаВыплаты) > 0";
		КолонкиРезультата = МенеджерВременныхТаблиц.Таблицы["ВТСписокСотрудников"].Колонки;
		Если КолонкиРезультата.Найти("ДокументОснование") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.ДокументОснование", "НЕОПРЕДЕЛЕНО") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СуммаНачисленная") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СуммаНачисленная", "0") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СуммаВыплаченная") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СуммаВыплаченная", "0") 
		КонецЕсли;
		Если КолонкиРезультата.Найти("СтатьяФинансирования") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СтатьяФинансирования", "НЕОПРЕДЕЛЕНО");
		КонецЕсли;
		Если КолонкиРезультата.Найти("СтатьяРасходов") = Неопределено Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеВедомости.СтатьяРасходов", "НЕОПРЕДЕЛЕНО") 
		КонецЕсли;
		Запрос.Текст = Запрос.Текст + ЗарплатаКадрыОбщиеНаборыДанных.РазделительЗапросов() + ТекстЗапроса;
		
		ТаблицыКУдалению.Добавить("ВТПоложительныеДоходы");
		ТаблицыКУдалению.Добавить("ВТДанныеДляОтбора");
	КонецЕсли;
	Запрос.Выполнить();
	
	// Коэффициенты
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Выплаты.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Выплаты.ДокументОснование КАК ДокументОснование,
	|	Выплаты.СтатьяФинансирования КАК СтатьяФинансирования,
	|	Выплаты.СтатьяРасходов КАК СтатьяРасходов,
	|	ВЫБОР
	|		КОГДА Выплаты.СуммаНачисленная = 0
	|			ТОГДА 1
	|		КОГДА Выплаты.СуммаНачисленная < 0
	|				И Выплаты.СуммаВыплаты = Выплаты.СуммаНачисленная
	|			ТОГДА 1
	|		КОГДА Выплаты.СуммаВыплаченная + Выплаты.СуммаВыплаты > Выплаты.СуммаНачисленная * &ДоляПолнойВыплаты
	|			ТОГДА 1
	|		ИНАЧЕ Выплаты.СуммаВыплаты / Выплаты.СуммаНачисленная
	|	КОНЕЦ КАК ДоляВыплаты
	|ПОМЕСТИТЬ ВТКоэффициентыВыплатыПоСтатьям
	|ИЗ
	|	ВТДанныеДляОтбора КАК Выплаты
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Выплаты.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Выплаты.ДокументОснование КАК ДокументОснование
	|ПОМЕСТИТЬ ВТОснованияФизическихЛиц
	|ИЗ
	|	ВТКоэффициентыВыплатыПоСтатьям КАК Выплаты
	|ГДЕ
	|	Выплаты.ДоляВыплаты > 0";
	Запрос.Выполнить();
	ТаблицыКУдалению.Добавить("ВТКоэффициентыВыплатыПоСтатьям");
	ТаблицыКУдалению.Добавить("ВТОснованияФизическихЛиц");
	
	// Учет доходов для исчисления НДФЛ
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СведенияОДоходахНДФЛ.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
	|	СведенияОДоходахНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
	|	СведенияОДоходахНДФЛ.МесяцНалоговогоПериода КАК МесяцНалоговогоПериода,
	|	СведенияОДоходахНДФЛ.КодДохода КАК КодДохода,
	|	СведенияОДоходахНДФЛ.КодВычета КАК КодВычета,
	|	СведенияОДоходахНДФЛ.КатегорияДохода КАК КатегорияДохода,
	|	СведенияОДоходахНДФЛ.СтавкаНалогообложения КАК СтавкаНалогообложения,
	|	СведенияОДоходахНДФЛ.ИсточникДоходаЗаПределамиРФ КАК ИсточникДоходаЗаПределамиРФ,
	|	СведенияОДоходахНДФЛ.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	СведенияОДоходахНДФЛ.Организация КАК Организация,
	|	СведенияОДоходахНДФЛ.Начисление КАК Начисление,
	|	СведенияОДоходахНДФЛ.Подразделение КАК Подразделение,
	|	СведенияОДоходахНДФЛ.Сотрудник КАК Сотрудник,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДохода КАК ДатаПолученияДохода,
	|	СведенияОДоходахНДФЛ.ДоходМежрасчетногоПериода КАК ДоходМежрасчетногоПериода,
	|	СведенияОДоходахНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль КАК ВключатьВДекларациюПоНалогуНаПрибыль,
	|	СведенияОДоходахНДФЛ.ПодразделениеСотрудника КАК ПодразделениеСотрудника,
	|	СведенияОДоходахНДФЛ.НеУчитыватьДоходВ6НДФЛ КАК НеУчитыватьДоходВ6НДФЛ,
	|	СведенияОДоходахНДФЛ.СтатьяФинансирования КАК СтатьяФинансирования,
	|	СведенияОДоходахНДФЛ.СтатьяРасходов КАК СтатьяРасходов,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДоходаФиксирована КАК ДатаПолученияДоходаФиксирована,
	|	СведенияОДоходахНДФЛ.ДокументОснование КАК ДокументОснование,
	|	СУММА(СведенияОДоходахНДФЛ.СуммаДохода) КАК СуммаДохода,
	|	СУММА(СведенияОДоходахНДФЛ.СуммаВычета) КАК СуммаВычета,
	|	СУММА(ВЫБОР
	|			КОГДА СведенияОДоходахНДФЛ.Регистратор = СведенияОДоходахНДФЛ.ДокументОснование
	|				ТОГДА СведенияОДоходахНДФЛ.СуммаДохода
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК ВаловаяСуммаДохода,
	|	СУММА(ВЫБОР
	|			КОГДА СведенияОДоходахНДФЛ.Регистратор = СведенияОДоходахНДФЛ.ДокументОснование
	|				ТОГДА СведенияОДоходахНДФЛ.СуммаВычета
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК ВаловаяСуммаВычета
	|ПОМЕСТИТЬ ВТЗаписиДоходов
	|ИЗ
	|	РегистрНакопления.СведенияОДоходахНДФЛ КАК СведенияОДоходахНДФЛ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТОснованияФизическихЛиц КАК Выплаты
	|		ПО СведенияОДоходахНДФЛ.ФизическоеЛицо = Выплаты.ФизическоеЛицо
	|			И СведенияОДоходахНДФЛ.ДокументОснование = Выплаты.ДокументОснование
	|ГДЕ
	|	СведенияОДоходахНДФЛ.Регистратор <> &Регистратор
	|	И СведенияОДоходахНДФЛ.УстаревшаяДатаПолученияДохода = ДАТАВРЕМЯ(1, 1, 1)
	|	И НЕ СведенияОДоходахНДФЛ.ДатаПолученияДоходаФиксирована
	|	И СведенияОДоходахНДФЛ.КатегорияДохода <> ЗНАЧЕНИЕ(Перечисление.КатегорииДоходовНДФЛ.ПустаяСсылка)
	|	И СведенияОДоходахНДФЛ.КатегорияДохода <> ЗНАЧЕНИЕ(Перечисление.КатегорииДоходовНДФЛ.ДоходыПредыдущихРедакций)
	|
	|СГРУППИРОВАТЬ ПО
	|	СведенияОДоходахНДФЛ.НеУчитыватьДоходВ6НДФЛ,
	|	СведенияОДоходахНДФЛ.СтатьяРасходов,
	|	СведенияОДоходахНДФЛ.СтавкаНалогообложения,
	|	СведенияОДоходахНДФЛ.ДокументОснование,
	|	СведенияОДоходахНДФЛ.Начисление,
	|	СведенияОДоходахНДФЛ.СтатьяФинансирования,
	|	СведенияОДоходахНДФЛ.МесяцНалоговогоПериода,
	|	СведенияОДоходахНДФЛ.ГоловнаяОрганизация,
	|	СведенияОДоходахНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль,
	|	СведенияОДоходахНДФЛ.КодВычета,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДоходаФиксирована,
	|	СведенияОДоходахНДФЛ.КатегорияДохода,
	|	СведенияОДоходахНДФЛ.ПодразделениеСотрудника,
	|	СведенияОДоходахНДФЛ.ДоходМежрасчетногоПериода,
	|	СведенияОДоходахНДФЛ.Сотрудник,
	|	СведенияОДоходахНДФЛ.ФизическоеЛицо,
	|	СведенияОДоходахНДФЛ.Организация,
	|	СведенияОДоходахНДФЛ.РегистрацияВНалоговомОргане,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДохода,
	|	СведенияОДоходахНДФЛ.Подразделение,
	|	СведенияОДоходахНДФЛ.ИсточникДоходаЗаПределамиРФ,
	|	СведенияОДоходахНДФЛ.КодДохода
	|
	|ИМЕЮЩИЕ
	|	(СУММА(СведенияОДоходахНДФЛ.СуммаДохода) <> 0
	|		ИЛИ СУММА(ВЫБОР
	|				КОГДА СведенияОДоходахНДФЛ.Регистратор = СведенияОДоходахНДФЛ.ДокументОснование
	|					ТОГДА СведенияОДоходахНДФЛ.СуммаДохода
	|				ИНАЧЕ 0
	|			КОНЕЦ) <> 0)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СведенияОДоходахНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
	|	СведенияОДоходахНДФЛ.КатегорияДохода КАК КатегорияДохода,
	|	СведенияОДоходахНДФЛ.ДокументОснование КАК ДокументОснование,
	|	СУММА(СведенияОДоходахНДФЛ.ВаловаяСуммаДохода) КАК СуммаДохода
	|ПОМЕСТИТЬ ВТИтогиПоДокументам
	|ИЗ
	|	ВТЗаписиДоходов КАК СведенияОДоходахНДФЛ
	|
	|СГРУППИРОВАТЬ ПО
	|	СведенияОДоходахНДФЛ.ДокументОснование,
	|	СведенияОДоходахНДФЛ.КатегорияДохода,
	|	СведенияОДоходахНДФЛ.ФизическоеЛицо
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СведенияОДоходахНДФЛ.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
	|	СведенияОДоходахНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
	|	СведенияОДоходахНДФЛ.МесяцНалоговогоПериода КАК МесяцНалоговогоПериода,
	|	СведенияОДоходахНДФЛ.КодДохода КАК КодДохода,
	|	СведенияОДоходахНДФЛ.КодВычета КАК КодВычета,
	|	СведенияОДоходахНДФЛ.КатегорияДохода КАК КатегорияДохода,
	|	СведенияОДоходахНДФЛ.СтавкаНалогообложения КАК СтавкаНалогообложения,
	|	СведенияОДоходахНДФЛ.ИсточникДоходаЗаПределамиРФ КАК ИсточникДоходаЗаПределамиРФ,
	|	СведенияОДоходахНДФЛ.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	СведенияОДоходахНДФЛ.Организация КАК Организация,
	|	СведенияОДоходахНДФЛ.Начисление КАК Начисление,
	|	СведенияОДоходахНДФЛ.Подразделение КАК Подразделение,
	|	СведенияОДоходахНДФЛ.Сотрудник КАК Сотрудник,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДохода КАК ДатаПолученияДохода,
	|	СведенияОДоходахНДФЛ.ДоходМежрасчетногоПериода КАК ДоходМежрасчетногоПериода,
	|	СведенияОДоходахНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль КАК ВключатьВДекларациюПоНалогуНаПрибыль,
	|	СведенияОДоходахНДФЛ.ПодразделениеСотрудника КАК ПодразделениеСотрудника,
	|	СведенияОДоходахНДФЛ.НеУчитыватьДоходВ6НДФЛ КАК НеУчитыватьДоходВ6НДФЛ,
	|	СведенияОДоходахНДФЛ.СтатьяФинансирования КАК СтатьяФинансирования,
	|	СведенияОДоходахНДФЛ.СтатьяРасходов КАК СтатьяРасходов,
	|	СведенияОДоходахНДФЛ.ДатаПолученияДоходаФиксирована КАК ДатаПолученияДоходаФиксирована,
	|	СведенияОДоходахНДФЛ.ДокументОснование КАК ДокументОснование,
	|	СведенияОДоходахНДФЛ.СуммаДохода КАК СуммаДохода,
	|	СведенияОДоходахНДФЛ.СуммаВычета КАК СуммаВычета,
	|	СведенияОДоходахНДФЛ.ВаловаяСуммаДохода КАК ВаловаяСуммаДохода,
	|	СведенияОДоходахНДФЛ.ВаловаяСуммаВычета КАК ВаловаяСуммаВычета,
	|	ЕСТЬNULL(ВаловыеСуммы.СуммаДохода, 0) КАК СуммаДоходаДокумента,
	|	Выплаты.ДоляВыплаты КАК ДоляВыплаты
	|ИЗ
	|	ВТЗаписиДоходов КАК СведенияОДоходахНДФЛ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТКоэффициентыВыплатыПоСтатьям КАК Выплаты
	|		ПО СведенияОДоходахНДФЛ.ФизическоеЛицо = Выплаты.ФизическоеЛицо
	|			И СведенияОДоходахНДФЛ.ДокументОснование = Выплаты.ДокументОснование
	|			И (СведенияОДоходахНДФЛ.СтатьяФинансирования = Выплаты.СтатьяФинансирования
	|				ИЛИ Выплаты.СтатьяФинансирования = НЕОПРЕДЕЛЕНО)
	|			И (СведенияОДоходахНДФЛ.СтатьяРасходов = Выплаты.СтатьяРасходов
	|				ИЛИ Выплаты.СтатьяРасходов = НЕОПРЕДЕЛЕНО)
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТИтогиПоДокументам КАК ВаловыеСуммы
	|		ПО СведенияОДоходахНДФЛ.ФизическоеЛицо = ВаловыеСуммы.ФизическоеЛицо
	|			И СведенияОДоходахНДФЛ.КатегорияДохода = ВаловыеСуммы.КатегорияДохода
	|			И СведенияОДоходахНДФЛ.ДокументОснование = ВаловыеСуммы.ДокументОснование
	|ГДЕ
	|	Выплаты.ДоляВыплаты > 0";
	ТаблицыКУдалению.Добавить("ВТЗаписиДоходов");
	ТаблицыКУдалению.Добавить("ВТИтогиПоДокументам");
	
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		ФизическиеЛица = Новый Массив;
		Организация = Неопределено;
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			СуммаДохода = 0;
			СуммаВычета = 0;
			Если Выборка.СуммаДохода * Выборка.СуммаДохода > (Выборка.ВаловаяСуммаДохода * Выборка.ДоляВыплаты) * (Выборка.ВаловаяСуммаДохода * Выборка.ДоляВыплаты) Тогда
				СуммаДохода = Выборка.ВаловаяСуммаДохода * Выборка.ДоляВыплаты;
			Иначе
				СуммаДохода = Выборка.СуммаДохода;
			КонецЕсли;
			Если Выборка.СуммаВычета * Выборка.СуммаВычета > (Выборка.ВаловаяСуммаВычета * Выборка.ДоляВыплаты) * (Выборка.ВаловаяСуммаВычета * Выборка.ДоляВыплаты) Тогда
				СуммаВычета = Выборка.ВаловаяСуммаВычета * Выборка.ДоляВыплаты;
			Иначе
				СуммаВычета = Выборка.СуммаВычета;
			КонецЕсли;
			
			ПеренесенныйДоход = ПеренесенныхДоходы.Добавить();
			ПеренесенныйДоход.ФизическоеЛицо = Выборка.ФизическоеЛицо;
			ПеренесенныйДоход.ДокументОснование = Выборка.ДокументОснование;
			ПеренесенныйДоход.КатегорияДохода = Выборка.КатегорияДохода;
			ПеренесенныйДоход.СуммаДохода = СуммаДохода;
			ПеренесенныйДоход.ОбщаяСуммаДохода = Выборка.СуммаДоходаДокумента;
			
			Если СуммаДохода = 0 Тогда 
				Продолжить;
			КонецЕсли;
			
			НовоеДвижение = Движения.СведенияОДоходахНДФЛ.Добавить();
			ЗаполнитьЗначенияСвойств(НовоеДвижение, Выборка);
			НовоеДвижение.СуммаДохода = - СуммаДохода;
			НовоеДвижение.СуммаВычета = - СуммаВычета;
			НовоеДвижение.Период = ДатаОперации;
			
			НовоеДвижение = Движения.СведенияОДоходахНДФЛ.Добавить();
			ЗаполнитьЗначенияСвойств(НовоеДвижение, Выборка);
			НовоеДвижение.СуммаДохода = СуммаДохода;
			НовоеДвижение.СуммаВычета = СуммаВычета;
			НовоеДвижение.УстаревшаяДатаПолученияДохода = Выборка.ДатаПолученияДохода;
			НовоеДвижение.ДатаПолученияДохода = ДатаВыплаты;
			НовоеДвижение.МесяцНалоговогоПериода = НачалоМесяца(ДатаВыплаты);
			НовоеДвижение.Период = ДатаОперации;
			
			ФизическиеЛица.Добавить(Выборка.ФизическоеЛицо);
			Если Не ЗначениеЗаполнено(Организация) Тогда
				Организация = Выборка.Организация
			КонецЕсли;
		КонецЦикла;
		Если Записывать Тогда
			Движения.СведенияОДоходахНДФЛ.Записать();
			Движения.СведенияОДоходахНДФЛ.Записывать = Ложь;
		Иначе
			Движения.СведенияОДоходахНДФЛ.Записывать = Истина;
		КонецЕсли;
		УчетНДФЛ.СформироватьДокументыУчтенныеПриРасчетеДляМежрасчетногоДокумента(Движения, Отказ, Организация, ФизическиеЛица, Регистратор);
	КонецЕсли;
	
	// Расчеты налогоплательщиков с бюджетом по НДФЛ
	ПеренесенныхДоходы.Свернуть("ФизическоеЛицо, ДокументОснование, КатегорияДохода, ОбщаяСуммаДохода", "СуммаДохода");
	ВсегоСтрок = ПеренесенныхДоходы.Количество();
	Для Инд = 1 По ВсегоСтрок Цикл
		СтрокаДохода = ПеренесенныхДоходы[ВсегоСтрок - Инд];
		Если СтрокаДохода.СуммаДохода = 0 Тогда
			ПеренесенныхДоходы.Удалить(СтрокаДохода);
		КонецЕсли;
	КонецЦикла;
	ЗарплатаКадры.СоздатьВТПоТаблицеЗначений(Запрос.МенеджерВременныхТаблиц, ПеренесенныхДоходы, "ВТПеренесенныеДоходы");
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ИСТИНА КАК СоединятьПоДокументам,
	|	ПеренесенныеДоходы.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ПеренесенныеДоходы.КатегорияДохода КАК КатегорияДохода,
	|	ПеренесенныеДоходы.ДокументОснование КАК ДокументОснование,
	|	ПеренесенныеДоходы.СуммаДохода КАК СуммаДохода,
	|	ПеренесенныеДоходы.ОбщаяСуммаДохода КАК ОбщаяСуммаДохода
	|ПОМЕСТИТЬ ВТДолиПеренесенныхДоходов
	|ИЗ
	|	ВТПеренесенныеДоходы КАК ПеренесенныеДоходы
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЛОЖЬ,
	|	ПеренесенныеДоходы.ФизическоеЛицо,
	|	ПеренесенныеДоходы.КатегорияДохода,
	|	НЕОПРЕДЕЛЕНО,
	|	СУММА(ПеренесенныеДоходы.СуммаДохода),
	|	СУММА(ПеренесенныеДоходы.ОбщаяСуммаДохода)
	|ИЗ
	|	ВТПеренесенныеДоходы КАК ПеренесенныеДоходы
	|
	|СГРУППИРОВАТЬ ПО
	|	ПеренесенныеДоходы.ФизическоеЛицо,
	|	ПеренесенныеДоходы.КатегорияДохода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеДляОтбора.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ДанныеДляОтбора.ДокументОснование КАК ДокументОснование
	|ПОМЕСТИТЬ ВТОснованияИсчисленногоНалога
	|ИЗ
	|	ВТДанныеДляОтбора КАК ДанныеДляОтбора
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СтавкаНалогообложенияРезидента КАК СтавкаНалогообложенияРезидента,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.МесяцНалоговогоПериода КАК МесяцНалоговогоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода КАК КатегорияДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Организация КАК Организация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КодДохода КАК КодДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Подразделение КАК Подразделение,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование КАК ДокументОснование,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВариантУдержания КАК ВариантУдержания,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль КАК ВключатьВДекларациюПоНалогуНаПрибыль,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РасчетМежрасчетногоПериода КАК РасчетМежрасчетногоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СрокПеречисления КАК СрокПеречисления,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КрайнийСрокУплаты КАК КрайнийСрокУплаты,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.УчитыватьВыплаченныйДоходВ6НДФЛ КАК УчитыватьВыплаченныйДоходВ6НДФЛ,
	|	СУММА(РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Сумма) КАК Сумма,
	|	СУММА(ВЫБОР
	|			КОГДА РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Регистратор = РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование
	|				ТОГДА РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Сумма
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК ВаловаяСумма
	|ПОМЕСТИТЬ ВТРасчетыНалогоплательщиков
	|ИЗ
	|	РегистрНакопления.РасчетыНалогоплательщиковСБюджетомПоНДФЛ КАК РасчетыНалогоплательщиковСБюджетомПоНДФЛ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТОснованияИсчисленногоНалога КАК Основания
	|		ПО РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо = Основания.ФизическоеЛицо
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование = Основания.ДокументОснование
	|ГДЕ
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Регистратор <> &Регистратор
	|	И НЕ РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДатаПолученияДоходаФиксирована
	|	И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода <> ЗНАЧЕНИЕ(Перечисление.КатегорииДоходовНДФЛ.ПустаяСсылка)
	|	И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода <> ЗНАЧЕНИЕ(Перечисление.КатегорииДоходовНДФЛ.ДоходыПредыдущихРедакций)
	|	И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.УстаревшаяДатаПолученияДохода = ДАТАВРЕМЯ(1, 1, 1)
	|	И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|
	|СГРУППИРОВАТЬ ПО
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.УчитыватьВыплаченныйДоходВ6НДФЛ,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КрайнийСрокУплаты,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СрокПеречисления,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РасчетМежрасчетногоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВариантУдержания,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Подразделение,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.МесяцНалоговогоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РегистрацияВНалоговомОргане,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СтавкаНалогообложенияРезидента,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ГоловнаяОрганизация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Организация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КодДохода
	|
	|ИМЕЮЩИЕ
	|	СУММА(РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Сумма) <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СтавкаНалогообложенияРезидента КАК СтавкаНалогообложенияРезидента,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.МесяцНалоговогоПериода КАК МесяцНалоговогоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода КАК КатегорияДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Организация КАК Организация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КодДохода КАК КодДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Подразделение КАК Подразделение,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование КАК ДокументОснование,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВариантУдержания КАК ВариантУдержания,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль КАК ВключатьВДекларациюПоНалогуНаПрибыль,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РасчетМежрасчетногоПериода КАК РасчетМежрасчетногоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СрокПеречисления КАК СрокПеречисления,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КрайнийСрокУплаты КАК КрайнийСрокУплаты,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.УчитыватьВыплаченныйДоходВ6НДФЛ КАК УчитыватьВыплаченныйДоходВ6НДФЛ,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Сумма КАК Сумма,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВаловаяСумма КАК ВаловаяСумма,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(Выплаты.ОбщаяСуммаДохода, 0) = 0
	|			ТОГДА 1
	|		ИНАЧЕ Выплаты.СуммаДохода / Выплаты.ОбщаяСуммаДохода
	|	КОНЕЦ КАК ДоляВыплаты
	|ИЗ
	|	ВТРасчетыНалогоплательщиков КАК РасчетыНалогоплательщиковСБюджетомПоНДФЛ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДолиПеренесенныхДоходов КАК Выплаты
	|		ПО РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо = Выплаты.ФизическоеЛицо
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода = Выплаты.КатегорияДохода
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование = Выплаты.ДокументОснование
	|			И (Выплаты.СоединятьПоДокументам)
	|ГДЕ
	|	ВЫБОР
	|			КОГДА ЕСТЬNULL(Выплаты.ОбщаяСуммаДохода, 0) = 0
	|				ТОГДА 1
	|			ИНАЧЕ Выплаты.СуммаДохода / Выплаты.ОбщаяСуммаДохода
	|		КОНЕЦ > 0
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ГоловнаяОрганизация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СтавкаНалогообложенияРезидента,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.МесяцНалоговогоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РегистрацияВНалоговомОргане,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Организация,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КодДохода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Подразделение,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВариантУдержания,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВключатьВДекларациюПоНалогуНаПрибыль,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.РасчетМежрасчетногоПериода,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.СрокПеречисления,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КрайнийСрокУплаты,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.УчитыватьВыплаченныйДоходВ6НДФЛ,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Сумма,
	|	РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ВаловаяСумма,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(Выплаты.ОбщаяСуммаДохода, 0) = 0
	|			ТОГДА 1
	|		ИНАЧЕ Выплаты.СуммаДохода / Выплаты.ОбщаяСуммаДохода
	|	КОНЕЦ
	|ИЗ
	|	ВТРасчетыНалогоплательщиков КАК РасчетыНалогоплательщиковСБюджетомПоНДФЛ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДолиПеренесенныхДоходов КАК Выплаты
	|		ПО РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо = Выплаты.ФизическоеЛицо
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода = Выплаты.КатегорияДохода
	|			И (Выплаты.СоединятьПоДокументам = ЛОЖЬ)
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТДолиПеренесенныхДоходов КАК УчтенныеВыплаты
	|		ПО РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ФизическоеЛицо = УчтенныеВыплаты.ФизическоеЛицо
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.КатегорияДохода = УчтенныеВыплаты.КатегорияДохода
	|			И РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДокументОснование = УчтенныеВыплаты.ДокументОснование
	|			И (УчтенныеВыплаты.СоединятьПоДокументам)
	|ГДЕ
	|	УчтенныеВыплаты.ФизическоеЛицо ЕСТЬ NULL
	|	И ВЫБОР
	|			КОГДА ЕСТЬNULL(Выплаты.ОбщаяСуммаДохода, 0) = 0
	|				ТОГДА 1
	|			ИНАЧЕ Выплаты.СуммаДохода / Выплаты.ОбщаяСуммаДохода
	|		КОНЕЦ > 0";
	ТаблицыКУдалению.Добавить("ВТПеренесенныеДоходы");
	ТаблицыКУдалению.Добавить("ВТДолиПеренесенныхДоходов");
	ТаблицыКУдалению.Добавить("ВТОснованияИсчисленногоНалога");
	ТаблицыКУдалению.Добавить("ВТРасчетыНалогоплательщиков");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Сумма = 0;
		Если Выборка.Сумма * Выборка.Сумма > (Выборка.ВаловаяСумма * Выборка.ДоляВыплаты) * (Выборка.ВаловаяСумма * Выборка.ДоляВыплаты) Тогда
			Сумма = Выборка.ВаловаяСумма * Выборка.ДоляВыплаты;
		Иначе
			Сумма = Выборка.Сумма;
		КонецЕсли;
		Если Сумма = 0 Тогда 
			Продолжить;
		КонецЕсли;
		
		НовоеДвижение = Движения.РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДобавитьПриход();
		ЗаполнитьЗначенияСвойств(НовоеДвижение, Выборка);
		НовоеДвижение.Сумма = - Сумма;
		НовоеДвижение.Период = ДатаОперации;
		
		НовоеДвижение = Движения.РасчетыНалогоплательщиковСБюджетомПоНДФЛ.ДобавитьПриход();
		ЗаполнитьЗначенияСвойств(НовоеДвижение, Выборка);
		НовоеДвижение.Сумма = Сумма;
		НовоеДвижение.УстаревшаяДатаПолученияДохода = Выборка.МесяцНалоговогоПериода;
		НовоеДвижение.МесяцНалоговогоПериода = ДатаВыплаты;
		НовоеДвижение.Период = ДатаОперации;
		
	КонецЦикла;
	Если Записывать Тогда
		Движения.РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Записать();
		Движения.РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Записывать = Ложь;
	Иначе
		Движения.РасчетыНалогоплательщиковСБюджетомПоНДФЛ.Записывать = Истина;
	КонецЕсли;
	
	ЗарплатаКадры.УничтожитьВТ(Запрос.МенеджерВременныхТаблиц, ТаблицыКУдалению);
	
КонецПроцедуры

#КонецОбласти
