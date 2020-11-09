///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ОбщегоНазначения.ИнформационнаяБазаФайловая() Тогда
		Элементы.ПутьКАрхивуWindows.Заголовок = НСтр("ru = 'Для сервера 1С:Предприятия под управлением Microsoft Windows'"); 
	Иначе
		Элементы.ПутьКАрхивуWindows.КнопкаВыбора = Ложь; 
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Авто;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПутьКАрхивуWindowsНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Не РаботаСФайламиСлужебныйКлиент.РасширениеРаботыСФайламиПодключено() Тогда
		РаботаСФайламиСлужебныйКлиент.ПоказатьПредупреждениеОНеобходимостиРасширенияРаботыСФайлами(Неопределено);
		Возврат;
	КонецЕсли;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	Диалог.Заголовок                    = НСтр("ru = 'Выберите файл'");
	Диалог.ПолноеИмяФайла               = ?(ЭтотОбъект.ПутьКАрхивуWindows = "", "files.zip", ЭтотОбъект.ПутьКАрхивуWindows);
	Диалог.МножественныйВыбор           = Ложь;
	Диалог.ПредварительныйПросмотр      = Ложь;
	Диалог.ПроверятьСуществованиеФайла  = Истина;
	Диалог.Фильтр                       = НСтр("ru = 'Архивы zip(*.zip)|*.zip'");
	
	Если Диалог.Выбрать() Тогда
		
		ЭтотОбъект.ПутьКАрхивуWindows = Диалог.ПолноеИмяФайла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Разместить(Команда)
	
	ОчиститьСообщения();
	
	Если ПустаяСтрока(ПутьКАрхивуWindows) И ПустаяСтрока(ПутьКАрхивуLinux) Тогда
		Текст = НСтр("ru = 'Укажите полное имя архива с
		                   |файлами начального образа (файл *.zip)'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(Текст, , "ПутьКАрхивуWindows");
		Возврат;
	КонецЕсли;
	
	Если Не ОбщегоНазначенияКлиент.ИнформационнаяБазаФайловая() Тогда
	
		Если Не ПустаяСтрока(ПутьКАрхивуWindows) И (Лев(ПутьКАрхивуWindows, 2) <> "\\" ИЛИ СтрНайти(ПутьКАрхивуWindows, ":") <> 0) Тогда
			ТекстОшибки = НСтр("ru = 'Путь к архиву с файлами начального образа
			                         |должен быть в формате UNC (\\servername\resource).'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки, , "ПутьКАрхивуWindows");
			Возврат;
		КонецЕсли;
	
	КонецЕсли;
	
	ДобавитьФайлыВТома();
	
	ТекстОповещения = НСтр("ru = 'Размещение файлов из архива с файлами
		|начального образа успешно завершено.'");
	ПоказатьОповещениеПользователя(НСтр("ru = 'Размещение файлов'"),, ТекстОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДобавитьФайлыВТома()
	
	РаботаСФайламиВТомахСлужебный.ДобавитьФайлыВТома(ПутьКАрхивуWindows, ПутьКАрхивуLinux);
	
КонецПроцедуры

#КонецОбласти
