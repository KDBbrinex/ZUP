#Область СлужебныеПроцедурыИФункции


Функция ИмяКаталогаЭлектронныхКурсов() Экспорт
	Возврат "v8courses";
КонецФункции


// Хранит дату изменения макетов электронных курсов.
//
// Возвращаемое значение:
//  Дата - Дата изменения поставляемых шаблонов.
//
Функция ДатаИзмененияМакетов() Экспорт
	
	Возврат Дата(2019, 03, 27, 17, 39, 00);
	
КонецФункции

#Если НЕ ВебКлиент Тогда

// Выгружает макет электронного курса в каталог.
//
// Параметры:
//   ПутьККаталогуЭлектронныхКурсов - Строка - путь к каталогу с электронными курсами.
//
Процедура ВыполнитьНачальноеЗаполнениеКаталогаЭлектронныхКурсов(ПутьККаталогуЭлектронныхКурсов, ВремяИзмененияМакетаДляУстановки = Неопределено) Экспорт
		
	КаталогЭлектронныхКурсов = Новый Файл(ПутьККаталогуЭлектронныхКурсов);
	
	Если КаталогЭлектронныхКурсов.Существует() Тогда
		
		СтартовыйФайл = Новый Файл(ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(ПутьККаталогуЭлектронныхКурсов, "index.html"));
		
		Если СтартовыйФайл.Существует() 
			И КаталогЭлектронныхКурсов.ПолучитьВремяИзменения() >= ДатаИзмененияМакетов() Тогда
			
			Возврат; // Не надо обновлять макеты
			
		КонецЕсли;
		
	Иначе
		
		ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(КаталогЭлектронныхКурсов.ПолноеИмя);
		
	КонецЕсли;
	
	ДвоичныеДанныеМакета = ИзучениеЭлектронныхКурсовСлужебныйВызовСервера.МакетЭлектронногоКурса();
	
	Если ТипЗнч(ДвоичныеДанныеМакета) <> Тип("ДвоичныеДанные") Тогда
		ВызватьИсключение НСтр("ru = 'Двоичные данные макета не заданы'");
	КонецЕсли;	
	
	ПутьКАрхивуСМакетом = ОбщегоНазначенияКлиентСервер.ПолучитьПолноеИмяФайла(КаталогЭлектронныхКурсов.ПолноеИмя, "layout.zip");
	
	ДвоичныеДанныеМакета.Записать(ПутьКАрхивуСМакетом);
				
	ФайлАрхива = Новый ЧтениеZIPФайла(ПутьКАрхивуСМакетом);
	ФайлАрхива.ИзвлечьВсе(КаталогЭлектронныхКурсов.ПолноеИмя, РежимВосстановленияПутейФайловZIP.Восстанавливать); 
	ФайлАрхива.Закрыть(); 				

	Попытка
		УдалитьФайлы(ПутьКАрхивуСМакетом);
	Исключение
		ЭлектронноеОбучениеСлужебныйВызовСервера.ЗаписатьОшибкуВЖурналРегистрации(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Не удалось удалить файл с макетом
			|%1 по причине: %2'"), ПутьКАрхивуСМакетом, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()))
		);
	КонецПопытки;					
	
	Если ВремяИзмененияМакетаДляУстановки = Неопределено Тогда
		КаталогЭлектронныхКурсов.УстановитьВремяИзменения(ДатаИзмененияМакетов());		
	Иначе
		КаталогЭлектронныхКурсов.УстановитьВремяИзменения(ВремяИзмененияМакетаДляУстановки);		
	КонецЕсли;
	
	ПутьККаталогуРесурсов = ПутьККаталогуРесурсов(ПутьККаталогуЭлектронныхКурсов);	
	ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(ПутьККаталогуРесурсов);
		
КонецПроцедуры
	
Процедура ВыгрузитьДанныеПубликацииВКаталогРесурсов(Знач ПутьККаталогуЭлектронныхКурсов, Знач ЭлектронныйКурс, Знач ФрагментКурса = Неопределено, Знач УникальныйИдентификатор = Неопределено, Знач ЭтоЕдинственнаяПубликация = Ложь) Экспорт
	
	ПутьККаталогуРесурсов = ПутьККаталогуРесурсов(ПутьККаталогуЭлектронныхКурсов);
	ПутьКФайлуСДанными = ПутьКФайлуСДаннымиПубликации(ПутьККаталогуРесурсов, ЭлектронныйКурс, ФрагментКурса, ЭтоЕдинственнаяПубликация);
	
	ФайлСДанными = Новый Файл(ПутьКФайлуСДанными);
	ДатаСуществующегоФайла = ?(ФайлСДанными.Существует(), ФайлСДанными.ПолучитьВремяИзменения(), Неопределено);
	
	ДанныеПубликации = ИзучениеЭлектронныхКурсовСлужебныйВызовСервера.ДанныеПубликации(ЭлектронныйКурс, ФрагментКурса, ДатаСуществующегоФайла);
	
	СкопироватьНаДискДанныеПубликации(ДанныеПубликации, ПутьККаталогуРесурсов, ЭлектронныйКурс, ФрагментКурса, УникальныйИдентификатор, ЭтоЕдинственнаяПубликация);
		
КонецПроцедуры

Процедура СкопироватьНаДискДанныеПубликации(Знач ДанныеПубликации, Знач ПутьККаталогуРесурсов, Знач ЭлектронныйКурс, Знач ФрагментКурса = Неопределено, Знач УникальныйИдентификатор = Неопределено, Знач ЭтоЕдинственнаяПубликация = Ложь) Экспорт
	
	Если ДанныеПубликации <> Неопределено Тогда
	
		ВыгрузитьНаборыФайловВКаталогРесурсов(ДанныеПубликации.Ресурсы, ПутьККаталогуРесурсов, ЭлектронныйКурс, УникальныйИдентификатор);
		
		ПутьКФайлуСДанными = ПутьКФайлуСДаннымиПубликации(ПутьККаталогуРесурсов, ЭлектронныйКурс, ФрагментКурса, ЭтоЕдинственнаяПубликация);

		ТекстДанных = Новый ЗаписьТекста(ПутьКФайлуСДанными);
		ТекстДанных.Записать(ДанныеПубликации.СтруктураКурса);
		ТекстДанных.Закрыть();			
		
	КонецЕсли;		
	
КонецПроцедуры

Функция ПутьКФайлуСДаннымиПубликации(Знач ПутьККаталогуРесурсов, Знач ЭлектронныйКурс, Знач ФрагментКурса = Неопределено, Знач ЭтоЕдинственнаяПубликация = Ложь)
		
	Если ЭтоЕдинственнаяПубликация Тогда
		ИмяФайла = "data";
	Иначе
		ИмяФайла = ИдентификаторДанныхПубликации(ЭлектронныйКурс, ФрагментКурса);
	КонецЕсли;
	
	Возврат ПутьККаталогуРесурсов + ИмяФайла + ".js"
	
КонецФункции

Функция ПутьККаталогуРесурсов(Знач ПутьККаталогуЭлектронныхКурсов) Экспорт
	КаталогСДаннымиКурсов = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогуЭлектронныхКурсов) + "data";
	КаталогСДаннымиКурсов = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(КаталогСДаннымиКурсов);
	Возврат КаталогСДаннымиКурсов;
КонецФункции

// Путь к каталогу, где хранятся данные изучения курсов.
// Используется при локальном изучении курсов, где данные
// изучения выгружаются в js файл и попадают в плеер курса из него.
//
Функция ПутьККаталогуСДаннымиИзучения(Знач ПутьККаталогуЭлектронныхКурсов) Экспорт	
	КаталогСДаннымиИзучения = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогуЭлектронныхКурсов) + "learning";
	КаталогСДаннымиИзучения = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(КаталогСДаннымиИзучения);
	Возврат КаталогСДаннымиИзучения;	
КонецФункции


// В тонком клиенте выгружает файлы ресурсов в локальный кэш.
//
Процедура ВыгрузитьНаборыФайловВКаталогРесурсов(МассивРесурсов, ПутьККаталогуРесурсов, ЭлектронныйРесурс = Неопределено, ИдентификаторФормы = Неопределено)
	
	ПутьККаталогуРесурсов = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогуРесурсов);
	
	// МассивРесурсов - массив содержащий структуры.
	
	Если МассивРесурсов = Неопределено
		ИЛИ МассивРесурсов.Количество() = 0 Тогда
		
		Возврат;
		
	КонецЕсли;
	
	// Получаем список только тех ресурсов, которые необходимо кэшировать
	
	МассивРесурсовДляОбновления = Новый Массив();
	КаталогиДляОбновления = Новый Массив();
	
	Для каждого Ресурс Из МассивРесурсов Цикл
		
		ПутьККаталогуРесурса = ПутьККаталогуРесурсов + Ресурс.Идентификатор + Ресурс.Постфикс;
		ПутьККаталогуРесурса = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогуРесурса);
		
		Если КаталогиДляОбновления.Найти(ПутьККаталогуРесурса) <> Неопределено Тогда
			МассивРесурсовДляОбновления.Добавить(Ресурс);
			Продолжить;
		КонецЕсли;
		
		КаталогРесурса = Новый Файл(ПутьККаталогуРесурса);
		
		Если НЕ КаталогРесурса.Существует() Тогда
			
			ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(КаталогРесурса.ПолноеИмя);
			КаталогРесурсаСоздан = Истина;
			
			Если КаталогРесурсаСоздан Тогда
				МассивРесурсовДляОбновления.Добавить(Ресурс);
				КаталогиДляОбновления.Добавить(ПутьККаталогуРесурса);
			КонецЕсли;
			
		Иначе
			
			Если (Ресурс.ДатаИзменения <> Неопределено И КаталогРесурса.ПолучитьВремяИзменения() < Ресурс.ДатаИзменения) ИЛИ ЭлектронноеОбучениеСлужебныйКлиентСервер.ИскатьФайлы(КаталогРесурса.ПолноеИмя, "*", Ложь).Количество() = 0 Тогда
				
				УдалитьФайлы(КаталогРесурса.ПолноеИмя);
				КаталогРесурсаУдален = Истина;
			
				Если КаталогРесурсаУдален Тогда
					
					ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(КаталогРесурса.ПолноеИмя);
					КаталогРесурсаСоздан = Истина;
					
					Если КаталогРесурсаСоздан Тогда
						МассивРесурсовДляОбновления.Добавить(Ресурс);
						КаталогиДляОбновления.Добавить(ПутьККаталогуРесурса);
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если МассивРесурсовДляОбновления.Количество() > 0 Тогда
		
		#Если ТонкийКлиент Тогда
		Если МассивРесурсовДляОбновления.Количество() > 5 Тогда
			Состояние(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Выполняется получение из базы данных %1 файлов курса.'"), Строка(МассивРесурсовДляОбновления.Количество())),,НСТр("ru = 'Пожалуйста, подождите.'"));
		КонецЕсли;
		Если МассивРесурсовДляОбновления.Количество() = 1
			И МассивРесурсовДляОбновления[0].Свойство("SCO")
			И МассивРесурсовДляОбновления[0].SCO Тогда
			Состояние(НСтр("ru = 'Выполняется получение из базы данных курса SCORM.
			|Это может занять продолжительное время...'"));
		КонецЕсли;
		#КонецЕсли		
		
		// Примечание: при нахождении на клиенте будет вызван сервер.
		МассивФайлов = ЭлектронноеОбучениеСлужебныйВызовСервера.ДанныеРесурсовДляВыгрузкиВКэш(МассивРесурсовДляОбновления, ЭлектронныйРесурс, ИдентификаторФормы);
		
		СкопироватьФайлыВКаталогРесурсов(МассивФайлов, ПутьККаталогуРесурсов, Истина);			
		
	КонецЕсли;
		
КонецПроцедуры

// Выгружает файлы в локальный кэш на клиенте
//
Процедура СкопироватьФайлыВКаталогРесурсов(МассивФайлов, ПутьККаталогу, ЭтоПервыйУровень)
	
	ПутьККаталогу = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьККаталогу);
	
	КоличествоФайлов = МассивФайлов.Количество();
	ЗагруженоФайлов = 0;
	Для каждого Элемент Из МассивФайлов Цикл
		
		#Если ТонкийКлиент Тогда
		Если ЭтоПервыйУровень И КоличествоФайлов > 5 Тогда
			ЗагруженоФайлов = ЗагруженоФайлов + 1;
			Состояние(НСтр("ru = 'Выполняется копирование файлов курса на диск....'"),Окр(ЗагруженоФайлов/КоличествоФайлов*100),НСТр("ru = 'Пожалуйста, подождите.'"));			
		КонецЕсли;
		#КонецЕсли			
		
		Если Элемент.ЭтоКаталог Тогда
			
			ПутьКВложенномуКаталогу = ПутьККаталогу + Элемент.ИмяФайла;
			ПутьКВложенномуКаталогу = ЭлектронноеОбучениеСлужебныйКлиентСервер.ДобавитьКонечныйРазделительПути(ПутьКВложенномуКаталогу);
			
			ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(ПутьКВложенномуКаталогу);
			
			Если Элемент.ПодчиненныеФайлы <> Неопределено Тогда
				СкопироватьФайлыВКаталогРесурсов(Элемент.ПодчиненныеФайлы, ПутьКВложенномуКаталогу, Ложь); // Рекурсия
			КонецЕсли;
			
		Иначе
			
			Если Элемент.ТипЭлемента = "Folder" ИЛИ Элемент.ТипЭлемента = "Document" Тогда
				
				Если ЗначениеЗаполнено(Элемент.ИмяФайла) Тогда				
					КаталогСохраняемогоФайла = ПутьККаталогу + Элемент.ИмяФайла;					
					ПолноеИмяСохраняемогоФайла = ПутьККаталогу + Элемент.ИмяФайла + ".zip";					
					ЭлектронноеОбучениеСлужебныйКлиентСервер.НовыйКаталог(КаталогСохраняемогоФайла);
				Иначе					
					КаталогСохраняемогоФайла = ПутьККаталогу;
					ПолноеИмяСохраняемогоФайла = ПутьККаталогу + "4002580234.zip";					
				КонецЕсли;
					
				Элемент.ДвоичныеДанные.Записать(ПолноеИмяСохраняемогоФайла);
				
				ФайлАрхива = Новый ЧтениеZIPФайла(ПолноеИмяСохраняемогоФайла);
				ФайлАрхива.ИзвлечьВсе(КаталогСохраняемогоФайла, РежимВосстановленияПутейФайловZIP.Восстанавливать); 
				ФайлАрхива.Закрыть(); 				

				Попытка
					УдалитьФайлы(ПолноеИмяСохраняемогоФайла);
				Исключение
					ЭлектронноеОбучениеСлужебныйВызовСервера.ЗаписатьОшибкуВЖурналРегистрации(
						СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Не удалось удалить временный файл
						|%1 по причине: %2'"), ПолноеИмяСохраняемогоФайла, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()))
					);
				КонецПопытки;					
				
				Продолжить;
				
			Иначе
				
				Если ТипЗнч(Элемент.ДвоичныеДанные) = Тип("ОписаниеПередаваемогоФайла") Тогда
					
					#Если ТонкийКлиент Тогда						
					ПолучаемыеФайла = Новый Массив;
					ПолучаемыеФайла.Добавить(Элемент.ДвоичныеДанные);						
					ПолучитьФайлы(ПолучаемыеФайла,,ПутьККаталогу,Ложь);						
					Продолжить;
					#КонецЕсли						
					
				КонецЕсли;
				
				Если ТипЗнч(Элемент.ДвоичныеДанные) = Тип("ДвоичныеДанные") Тогда 
					
					Элемент.ДвоичныеДанные.Записать(ПутьККаталогу + Элемент.ИмяФайла);
					Продолжить;
					
				КонецЕсли;
								
			КонецЕсли;
			
			ВызватьИсключение НСтр("ru = 'Неизвестный тип данных ресурса'");
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецЕсли

Функция ИдентификаторДанныхПубликации(Знач ЭлектронныйКурс, Знач ФрагментКурса = Неопределено) Экспорт	
		
	Если ЗначениеЗаполнено(ФрагментКурса) И ФрагментКурса <> ЭлектронныйКурс Тогда
			
		Если ФрагментКурса = ПредопределенноеЗначение("Перечисление.ТипыЭлементовСодержанияЭлектронногоКурса.Начало") Тогда
			Возврат Строка(ЭлектронныйКурс.УникальныйИдентификатор()) + "-start";
		ИначеЕсли ФрагментКурса = ПредопределенноеЗначение("Перечисление.ТипыЭлементовСодержанияЭлектронногоКурса.Финальный") Тогда
			Возврат Строка(ЭлектронныйКурс.УникальныйИдентификатор()) + "-final";
		Иначе
			Возврат Строка(ФрагментКурса.УникальныйИдентификатор());
		КонецЕсли;	
			
	Иначе
		
		Возврат Строка(ЭлектронныйКурс.УникальныйИдентификатор());
		
	КонецЕсли;
	
КонецФункции

// Возвращает структуру параметров значений HTML ссылки.
//
// Параметры
//  АдресСсылки  - Строка, содержащая адрес ссылки.
//
// Возвращаемое значение:
//   Структура - содержит структуру параметров: Ключ (имя параметра) и Значение.
//
Функция СтруктураСтрокиПараметров(АдресСсылки, СимволНачала = "?", РазделительПараметров = "&", РазделительЗначения = "=", МассивЗначений = Ложь) Экспорт
	
	Если ТипЗнч(АдресСсылки)= Тип("Структура") Тогда
    	Возврат АдресСсылки;
    КонецЕсли;
	
	СтруктураПараметров = Новый Структура();			
	
	Если НЕ ЗначениеЗаполнено(АдресСсылки) Тогда
		Возврат СтруктураПараметров;
	КонецЕсли;
	
	// Находим начало строки параметров.
	
	Если ЗначениеЗаполнено(СимволНачала) Тогда
	
		НачалоПараметров = Найти(АдресСсылки, СимволНачала);
			
		Если НачалоПараметров > 0 Тогда
			СтрокаПараметров = Сред(АдресСсылки, НачалоПараметров+СтрДлина(СимволНачала));
		Иначе
			СтрокаПараметров = АдресСсылки;
		КонецЕсли;
		
	Иначе
		
		СтрокаПараметров = АдресСсылки;
		
	КонецЕсли;
		
	// Расщепляем строку
		
	МассивПараметров = Новый Массив();
	МассивПараметров = ЭлектронноеОбучениеСлужебныйКлиентСервер.СтрокаВебРазделить(СтрокаПараметров, РазделительПараметров);
	МассивЗначенийПараметра = Новый Массив;
		
	Для а = 0 По МассивПараметров.Количество()-1 Цикл
			
		НайтиРазделитель = Найти(МассивПараметров[а], РазделительЗначения);
			
		ТекИмяПараметра = Сред(МассивПараметров[а], 1, НайтиРазделитель-1);
		
		Если НЕ ЗначениеЗаполнено(ТекИмяПараметра) Тогда
			Продолжить;
		КонецЕсли;		
		
		ТекЗначениеПараметра = Сред(МассивПараметров[а], НайтиРазделитель+1, СтрДлина(МассивПараметров[а]));
		
		СущЗначениеПараметра = "";
		
		СтруктураПараметров.Свойство(ТекИмяПараметра, СущЗначениеПараметра);		
		
		// Если в структуре нет такого параметра, просто его добавляем.
		Если ПустаяСтрока(СущЗначениеПараметра) И НЕ МассивЗначений Тогда 
			
			СтруктураПараметров.Вставить(ТекИмяПараметра, ТекЗначениеПараметра);
			
		Иначе
			
			// Если такой параметр есть и значение его находится в массиве, то добавляем
			// текущий параметр в массив.
			Если ТипЗнч(СущЗначениеПараметра) = Тип("Массив") Тогда 
				СущЗначениеПараметра.Добавить(ТекЗначениеПараметра);
				СтруктураПараметров.Вставить(ТекИмяПараметра, СущЗначениеПараметра);
				
			// Если это второе значение параметра, то добавляем уже существующее и текущее
			// Значение в массив.	
			Иначе 
				МассивЗначЭтогоПараметра = Новый Массив();
				Если СущЗначениеПараметра <> Неопределено Тогда
					МассивЗначЭтогоПараметра.Добавить(СущЗначениеПараметра);
				КонецЕсли;
				МассивЗначЭтогоПараметра.Добавить(ТекЗначениеПараметра);
				СтруктураПараметров.Вставить(ТекИмяПараметра, МассивЗначЭтогоПараметра);
			КонецЕсли;
		КонецЕсли;
			
	КонецЦикла;

	
	Возврат СтруктураПараметров;
	
КонецФункции

// Получает значение параметра ссылки из структуры ссылки.
//
// Параметры
//  ПараметрыСсылки  - Структура.
//  ИмяПараметра     - Строка, имя параметра.
//
// Возвращаемое значение:
//   Строка или Неопределено, если параметр не найден.
//
Функция ЗначениеПараметраСсылки(ПараметрыСсылки, ИмяПараметра) Экспорт
	
	ЗначениеПараметра = Неопределено;
	ПараметрыСсылки.Свойство(ИмяПараметра, ЗначениеПараметра);
	
	Если ЗначениеПараметра = Неопределено Тогда
		
		// Если нет параметра window в ссылке, то по умолчанию параметр равен main.
		Если ИмяПараметра = "window" Тогда
			Возврат "main";
		Иначе
			Возврат Неопределено;	
		КонецЕсли;
		
	Иначе
		
		// Примечание: символы " ", "&", "=", "+" кодируются скриптом на клиенте,
		// Перед передачей на сервер, чтобы отличить их от служебных символов URL.
		// Здесь они преобразовываются обратно.
		
		Если ТипЗнч(ЗначениеПараметра) = Тип("Строка") Тогда
		
	        ЗначениеПараметра = СтрЗаменить(ЗначениеПараметра, "+", " "); 
			ЗначениеПараметра = СтрЗаменить(ЗначениеПараметра, "#x26", "&");
			ЗначениеПараметра = СтрЗаменить(ЗначениеПараметра, "#x3D", "=");
			ЗначениеПараметра = СтрЗаменить(ЗначениеПараметра, "#x2B", "+");
			ЗначениеПараметра = СтрЗаменить(ЗначениеПараметра, "#x3F", "?");
			
		КонецЕсли;
		
		Если ТипЗнч(ЗначениеПараметра) = Тип("Массив") Тогда
			
			ДлинаМассива = ЗначениеПараметра.Количество();
			
			Для Индекс = 0 По ДлинаМассива-1 Цикл
				
				Значение = ЗначениеПараметра[Индекс];
				
				Если ТипЗнч(Значение) = Тип("Строка") Тогда
					 
			        Значение = СтрЗаменить(Значение, "+", " "); 
					Значение = СтрЗаменить(Значение, "#x26", "&");
					Значение = СтрЗаменить(Значение, "#x3D", "=");
					Значение = СтрЗаменить(Значение, "#x2B", "+");
					Значение = СтрЗаменить(Значение, "#x3F", "?");
					 
				КонецЕсли;
			 
				ЗначениеПараметра[Индекс] = Значение;
				
			КонецЦикла;
			
		КонецЕсли;
		
		Возврат ЗначениеПараметра;
		
	КонецЕсли;
			
КонецФункции

#КонецОбласти

