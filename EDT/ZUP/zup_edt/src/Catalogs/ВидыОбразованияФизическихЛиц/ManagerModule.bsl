
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// ТехнологияСервиса.ВыгрузкаЗагрузкаДанных

// Возвращает реквизиты справочника, которые образуют естественный ключ для элементов справочника.
//
// Возвращаемое значение:
//  Массив из Строка - имена реквизитов, образующих естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Код");
	Результат.Добавить("ФасетОКИН");
	Результат.Добавить("ИмяПредопределенныхДанных");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ДанныеВыбораБЗК.ЗаполнитьДляКлассификатораСПорядкомПоКоду(
		Справочники.ВидыОбразованияФизическихЛиц,
		ДанныеВыбора, Параметры, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура выполняет первоначальное заполнение классификатора.
Процедура НачальноеЗаполнение() Экспорт
	
	ЗаполнитьВидыОбразований();
	
КонецПроцедуры
	
Процедура ЗаполнитьВидыОбразований()

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВидыОбразованияФизическихЛиц.Ссылка,
		|	ВидыОбразованияФизическихЛиц.ИмяПредопределенныхДанных,
		|	ВидыОбразованияФизическихЛиц.Код,
		|	ВидыОбразованияФизическихЛиц.ФасетОКИН,
		|	ВидыОбразованияФизическихЛиц.Наименование
		|ИЗ
		|	Справочник.ВидыОбразованияФизическихЛиц КАК ВидыОбразованияФизическихЛиц";
		
	ТаблицаСуществующихВидов = Запрос.Выполнить().Выгрузить();
	
	ТекстовыйДокумент = Справочники.ВидыОбразованияФизическихЛиц.ПолучитьМакет("КлассификаторВидовОбразования");
	ТаблицаКлассификатора = ОбщегоНазначения.ПрочитатьXMLВТаблицу(ТекстовыйДокумент.ПолучитьТекст()).Данные;
	
	Для каждого СтрокаКлассификатора Из ТаблицаКлассификатора Цикл
		
		ИмяПредопределенныхДанных = СтрокаКлассификатора.Name;
		Код = СтрокаКлассификатора.Code;
		ФасетОКИН = Число(СтрокаКлассификатора.FasetOKIN);
		Наименование = СтрокаКлассификатора.FullName;
		
		Если ЗначениеЗаполнено(ИмяПредопределенныхДанных) Тогда
			
			СсылкаНаЭлемент = ОбщегоНазначения.ПредопределенныйЭлемент("Справочник.ВидыОбразованияФизическихЛиц." + ИмяПредопределенныхДанных);
			Если СсылкаНаЭлемент = Неопределено Тогда
				СправочникОбъект = Справочники.ВидыОбразованияФизическихЛиц.СоздатьЭлемент();
				СправочникОбъект.ИмяПредопределенныхДанных = ИмяПредопределенныхДанных;
			Иначе
				СправочникОбъект = СсылкаНаЭлемент.ПолучитьОбъект();
			КонецЕсли;
			
		ИначеЕсли ЗначениеЗаполнено(Код) Тогда
			
			СтруктураПоиска = Новый Структура;
			СтруктураПоиска.Вставить("Код", Код);
			СтруктураПоиска.Вставить("ФасетОКИН", ФасетОКИН);
			
			НайденныеСтроки = ТаблицаСуществующихВидов.НайтиСтроки(СтруктураПоиска);
			Если НайденныеСтроки.Количество() > 0 Тогда
				СправочникОбъект = НайденныеСтроки[0].Ссылка.ПолучитьОбъект();
			Иначе
				СправочникОбъект = Справочники.ВидыОбразованияФизическихЛиц.СоздатьЭлемент();
			КонецЕсли;
			
		Иначе
			
			СтрокаКлассификатора = ТаблицаСуществующихВидов.Найти(Наименование, "Наименование");
			Если СтрокаКлассификатора = Неопределено Тогда
				СправочникОбъект = Справочники.ВидыОбразованияФизическихЛиц.СоздатьЭлемент();
			Иначе
				СправочникОбъект = СтрокаКлассификатора.Ссылка.ПолучитьОбъект();
			КонецЕсли;
			
		КонецЕсли; 
		
		Если СправочникОбъект.Код <> Код
			Или СправочникОбъект.ФасетОКИН <> ФасетОКИН 
			Или СправочникОбъект.Наименование <> Наименование Тогда
			
			СправочникОбъект.Код = Код;
			СправочникОбъект.ФасетОКИН = ФасетОКИН;
			СправочникОбъект.Наименование = Наименование;
			
			СправочникОбъект.ДополнительныеСвойства.Вставить("ПодборИзКлассификатора");
			
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(СправочникОбъект);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли