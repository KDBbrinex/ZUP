
#Область СлужебныеПроцедурыИФункции

// Типы файлов

// Возвращает тип элемента ресурса по его расширению.
//
Функция ТипЭлементаРесурсаПоРасширению(Знач Расширение) Экспорт
	
	Расширение               = СтрЗаменить(Расширение, ".", "");
	СоответствиеПоРасширению = СоответствиеРасширенияИТипаЭлементаРесурса();
	ТипПоУмолчанию           = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.File");
	
	ТипФайла = Неопределено;
	
	Если НЕ ПустаяСтрока(Расширение) Тогда
		
		СоответствиеПоРасширению.Свойство("_" + Расширение, ТипФайла);
		
		Если ТипФайла = Неопределено Тогда
			Возврат ТипПоУмолчанию;
		КонецЕсли;
		
	Иначе
		
		Возврат ТипПоУмолчанию;
		
	КонецЕсли;
	
	Если ТипФайла <> Неопределено Тогда
		Возврат ТипФайла;
	Иначе
		Возврат ТипПоУмолчанию;
	КонецЕсли;
	
КонецФункции

Функция СоответствиеРасширенияИТипаЭлементаРесурса(Знач ТипФайла = Неопределено) Экспорт
	
	ТипПоУмолчанию = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.File");
	ТипМедиаобъект = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Media");
	ТипИзображение = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Image");
	ТипКаталог     = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Folder");
	ТипВидео       = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Video");
	ТипАудио       = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Audio");
	ТипОбработка   = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.DataProcessor");	
	ТипДокумент    = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Document");
	ТипПрезентация = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Presentation");
	ТипТаблица     = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Table");
	
	СоответствиеПоРасширению = Новый Структура();
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипДокумент Тогда
		СоответствиеПоРасширению.Вставить("_doc", ТипОбработка);
		СоответствиеПоРасширению.Вставить("_docx", ТипОбработка);
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипПрезентация Тогда
		СоответствиеПоРасширению.Вставить("_ppt", ТипОбработка);
		СоответствиеПоРасширению.Вставить("_pptx", ТипОбработка);
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипИзображение Тогда
		
		СоответствиеПоРасширению.Вставить("_gif", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_jpg", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_jpeg", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_tiff", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_bmp", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_png", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_wmf", ТипИзображение);
		СоответствиеПоРасширению.Вставить("_emf", ТипИзображение);
		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипМедиаобъект Тогда		
		СоответствиеПоРасширению.Вставить("_swf", ТипМедиаобъект);	
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипВидео Тогда
	
		СоответствиеПоРасширению.Вставить("_avi", ТипВидео);
		СоответствиеПоРасширению.Вставить("_flv", ТипВидео);
		СоответствиеПоРасширению.Вставить("_mov", ТипВидео);
		СоответствиеПоРасширению.Вставить("_mpg", ТипВидео);
		СоответствиеПоРасширению.Вставить("_mpeg", ТипВидео);
		СоответствиеПоРасширению.Вставить("_mp4", ТипВидео);
		СоответствиеПоРасширению.Вставить("_wmv", ТипВидео);
		СоответствиеПоРасширению.Вставить("_3g2", ТипВидео);
		СоответствиеПоРасширению.Вставить("_3gp", ТипВидео);
		СоответствиеПоРасширению.Вставить("_ogv", ТипВидео);
		СоответствиеПоРасширению.Вставить("_webm", ТипВидео);
		СоответствиеПоРасширению.Вставить("_mkv", ТипВидео);
		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипАудио Тогда
	
		СоответствиеПоРасширению.Вставить("_aif", ТипАудио);
		СоответствиеПоРасширению.Вставить("_aac", ТипАудио);
		СоответствиеПоРасширению.Вставить("_au", ТипАудио);
		СоответствиеПоРасширению.Вставить("_gsm", ТипАудио);
		СоответствиеПоРасширению.Вставить("_mid", ТипАудио);
		СоответствиеПоРасширению.Вставить("_midi", ТипАудио);
		СоответствиеПоРасширению.Вставить("_mp3", ТипАудио);
		СоответствиеПоРасширению.Вставить("_m4a", ТипАудио);
		СоответствиеПоРасширению.Вставить("_snd", ТипАудио);
		СоответствиеПоРасширению.Вставить("_ra", ТипАудио);
		СоответствиеПоРасширению.Вставить("_ram", ТипАудио);
		СоответствиеПоРасширению.Вставить("_rm", ТипАудио);
		СоответствиеПоРасширению.Вставить("_wav", ТипАудио);
		СоответствиеПоРасширению.Вставить("_wma", ТипАудио);
		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипТаблица Тогда
		
		СоответствиеПоРасширению.Вставить("_xls", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_xlsx", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_mxl", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_ods", ТипПоУмолчанию);
		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипПоУмолчанию Тогда
		
		СоответствиеПоРасширению.Вставить("_doc", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_pdf", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_docx", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_xls", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_xlsx", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_rtf", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_ppt", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_pptx", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_htm", ТипПоУмолчанию);
		СоответствиеПоРасширению.Вставить("_html", ТипПоУмолчанию);
		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипОбработка Тогда	
		СоответствиеПоРасширению.Вставить("_epf", ТипОбработка);		
	КонецЕсли;
	
	Если ТипФайла = Неопределено ИЛИ ТипФайла = ТипКаталог Тогда
		СоответствиеПоРасширению.Вставить("_zip", ТипОбработка);		
	КонецЕсли;	
	
	Возврат Новый ФиксированнаяСтруктура(СоответствиеПоРасширению);
	
КонецФункции

Функция ДоступныеФорматыВидео() Экспорт
	
	ФорматыВидео = Новый Массив;
	ФорматыВидео.Добавить("MP4");
	ФорматыВидео.Добавить("WEBM");
	
	Возврат Новый ФиксированныйМассив(ФорматыВидео);
	
КонецФункции

Функция ОбязательныйФорматВидео() Экспорт
	
	Возврат "MP4";
	
КонецФункции

Функция ПутьКФайлуЗапускаДокумента(Знач ПутьККаталогу) Экспорт
	Возврат ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогу) + "index.html";
КонецФункции

Функция ЭтоФайлВидеоПоддерживаемогоФормата(Знач РасширениеИлиИмяФайла) Экспорт
	
	НужноеРасширениеБезТочки = НРег(ОбязательныйФорматВидео());
	НужноеРасширение = "." + НужноеРасширениеБезТочки;	
	
	Если Прав(НРег(РасширениеИлиИмяФайла), СтрДлина(НужноеРасширение)) = НужноеРасширение
		ИЛИ НРег(РасширениеИлиИмяФайла) = НужноеРасширениеБезТочки Тогда		
		
		Возврат Истина;		
		
	Иначе		
		
		Возврат Ложь;		
		
	КонецЕсли;	
	
КонецФункции

Функция ЭтоФайлПрезентации(Знач РасширениеИлиИмяФайла) Экспорт
	
	Если Прав(НРег(РасширениеИлиИмяФайла), 4) = ".ppt" 
		ИЛИ Прав(НРег(РасширениеИлиИмяФайла), 5) = ".pptx" Тогда
		
		Возврат Истина;
		
	Иначе
		
		Возврат Ложь;
		
	КонецЕсли;	
	
КонецФункции

Функция ЭтоФайлДокумента(Знач РасширениеФайла) Экспорт
	
	Если НРег(РасширениеФайла) = ".doc" ИЛИ НРег(РасширениеФайла) = ".docx" Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
		
КонецФункции

Функция ЭтоФайлТаблиц(Знач РасширениеФайла) Экспорт
	
	РасширениеНРег = НРег(РасширениеФайла);
	
	Если РасширениеНРег = ".xls" 
		ИЛИ РасширениеНРег = ".xlsx"
		ИЛИ РасширениеНРег = ".ods"
		ИЛИ РасширениеНРег = ".mxl" Тогда
		
		Возврат Истина;
		
	Иначе
		
		Возврат Ложь;
		
	КонецЕсли;
		
КонецФункции

Функция ЭтоФайлВидео(Знач РасширениеФайла) Экспорт
	
	ТипФайлаСУЗ = ТипЭлементаРесурсаПоРасширению(РасширениеФайла);
	
	Возврат ?(ТипФайлаСУЗ = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Video"), Истина, Ложь);
		
КонецФункции

Функция ЭтоФайлАудио(Знач РасширениеФайла) Экспорт
	
	ТипФайлаСУЗ = ТипЭлементаРесурсаПоРасширению(РасширениеФайла);
	
	Возврат ?(ТипФайлаСУЗ = ПредопределенноеЗначение("Перечисление.ТипыЭлементовЭлектронныхРесурсов.Audio"), Истина, Ложь);
		
КонецФункции

Функция ЭтоФайлHTML(Знач Расширение) Экспорт
	
	Расширение = СтрЗаменить(Расширение, ".", "");
	
	Если НРег(Расширение) = "htm" ИЛИ НРег(Расширение) = "html" Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

Функция ПустаяСтруктураСвойствВладельцаЗагружаемыхФайлов() Экспорт
	
	Возврат Новый Структура("
		|ИмяВладельцаФайлов,
		|ЭлектронныйКурс,
		|Теория,
		|НаборФайлов,
		|ЭлементСодержания,
		|СтраницаТеории,
		|Родитель,
		|ЗависимыеРесурсы,
		|ЗависимыеРесурсыДополняющиеAPI,
		|ОбновлятьДатуРесурса");	
	
КонецФункции

Функция ПустаяСтруктураСвойствЗагружаемогоФайла() Экспорт
	
	Возврат Новый Структура("
		|Имя,
		|Расширение,
		|ЭтоКаталог,
		|Преобразовать,
		|СтруктураФайлов,
		|СписокФайлов,
		|НастройкиКартинок,
		|ДанныеВидео,
		|КонтекстФайла,
		|ТекстовыеДанныеДляИндексирования");
	
КонецФункции

#КонецОбласти
