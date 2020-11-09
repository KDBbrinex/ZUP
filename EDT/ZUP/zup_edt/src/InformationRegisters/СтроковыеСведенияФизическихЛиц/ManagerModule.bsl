#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбновитьСтроковыеСведенияФизическогоЛица(ФизическоеЛицо, ПричинаОбновления = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	СтроковыеСведения = СтроковыеСведенияФизическогоЛица(ФизическоеЛицо);	
	
	ОбновлятьВсеСведения = ПричинаОбновления = Неопределено;
	
	Если ПричинаОбновления = "Документы"
		Или ОбновлятьВсеСведения Тогда
		ОбновитьДокументы(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "ЗнаниеЯзыков" 
		Или ОбновлятьВсеСведения Тогда
		ОбновитьЗнаниеЯзыков(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "Награды"
		Или ОбновлятьВсеСведения Тогда
		ОбновитьНаграды(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "Образование"
		Или ОбновлятьВсеСведения  Тогда
		ОбновитьОбучение(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "Профессии" 
		Или ОбновлятьВсеСведения Тогда
		ОбновитьПрофессии(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "СоставСемьи"
		Или ОбновлятьВсеСведения Тогда
		ОбновитьСоставСемьи(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "Специальности"
		Или ОбновлятьВсеСведения Тогда
		ОбновитьСпециальности(СтроковыеСведения);
	КонецЕсли;
	
	Если ПричинаОбновления = "ТрудоваяДеятельность"
		Или ОбновлятьВсеСведения Тогда
		ОбновитьТрудовуюДеятельность(СтроковыеСведения);
	КонецЕсли;
	
	ЗаписатьСтроковыеСведенияФизическогоЛица(СтроковыеСведения);
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#Область ЗаполнениеВторичныхДанныхПриОбменах

Процедура ПервоначальноеЗаполнениеСтроковыхСведенийФизическихЛиц(ПараметрыОбновления) Экспорт
	
	ФизическиеЛица = ФизическиеЛицаБезСтроковыхСведений();
	
	Если ОбновлениеСтроковыхСведенийЗавершено(ФизическиеЛица) Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьСтроковыеСведенияФизическихЛиц(ФизическиеЛица);
	
	ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область ОбменДанными

// Пересчитывает зависимые данные после загрузки сообщения обмена
//
// Параметры:
//		ЗависимыеДанные - ТаблицаЗначений:
//			* ВедущиеМетаданные - ОбъектМетаданных - Метаданные ведущих данных
//			* ЗависимыеМетаданные - ОбъектМетаданных - Метаданные текущего объекта
//			* ВедущиеДанные - Массив объектов, заполненный при загрузке сообщения обмена
//				по этим объектам требуется обновить зависимые данные
//
Процедура ОбновитьЗависимыеДанныеПослеЗагрузкиОбменаДанными(ЗависимыеДанные) Экспорт
	
	Для Каждого СтрокаТаблицы Из ЗависимыеДанные Цикл
		
		Для Каждого ВедущиеДанные Из СтрокаТаблицы.ВедущиеДанные Цикл
			
			ВедущиеДанные.ДополнительныеСвойства.Вставить("ПроверятьБизнесЛогикуПриЗаписи");
			Если ОбщегоНазначения.ЭтоСправочник(СтрокаТаблицы.ВедущиеМетаданные) Тогда
				
				Если СтрокаТаблицы.ВедущиеМетаданные = Метаданные.Справочники.ФизическиеЛица Тогда
					
					Если ВедущиеДанные.ДополнительныеСвойства.Свойство("ЭтоНовый")
						И ВедущиеДанные.ДополнительныеСвойства.ЭтоНовый = Истина Тогда
						
						ЗаполнитьСтроковыеСведенияФизическогоЛица(ВедущиеДанные.Ссылка)
					КонецЕсли;
					
				Иначе
					ЗарплатаКадрыРасширенныйСобытия.ОбновитьСтроковыеСведенияФизическогоЛицаПриЗаписиСправочника(ВедущиеДанные, Ложь);
				КонецЕсли;
				
			Иначе
				ЗарплатаКадрыРасширенныйСобытия.ОбновитьСтроковыеСведенияФизическогоЛицаПриЗаписиРегистраСведений(ВедущиеДанные, Ложь, Истина);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтроковыеСведенияФизическогоЛица(ФизическоеЛицо)
	
	СтроковыеСведения = СоздатьМенеджерЗаписи();
	СтроковыеСведения.ФизическоеЛицо = ФизическоеЛицо;
	СтроковыеСведения.Прочитать();
	Если НЕ СтроковыеСведения.Выбран() Тогда
		СтроковыеСведения.ФизическоеЛицо = ФизическоеЛицо;
	КонецЕсли;
	
	Возврат СтроковыеСведения;
	
КонецФункции 

Процедура ЗаписатьСтроковыеСведенияФизическогоЛица(СтроковыеСведения)
	
	СтроковыеСведения.Записать();
	
КонецПроцедуры

Функция ОбновитьДокументы(СтроковыеСведения)
	СтроковыеСведения.Документы = СтрокаДокументы(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьЗнаниеЯзыков(СтроковыеСведения)
	СтроковыеСведения.ЗнаниеЯзыков = СтрокаЗнаниеЯзыков(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьНаграды(СтроковыеСведения)
	СтроковыеСведения.Награды = СтрокаНаграды(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьОбучение(СтроковыеСведения)
	
	ДанныеОбОбучении = ДанныеОбОбучении(СтроковыеСведения.ФизическоеЛицо);
	
	Если ДанныеОбОбученииЗаполнены(ДанныеОбОбучении) Тогда
		СтроковыеСведения.Образование 			= СтрокаОбразование(ДанныеОбОбучении);
		СтроковыеСведения.ПовышениеКвалификации = СтрокаПовышениеКвалификации(ДанныеОбОбучении);
		СтроковыеСведения.Переподготовка 		= СтрокаПереподготовка(ДанныеОбОбучении);
	КонецЕсли;
	
КонецФункции

Функция ОбновитьПрофессии(СтроковыеСведения)
	СтроковыеСведения.Профессии = СтрокаПрофессии(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьСоставСемьи(СтроковыеСведения)
	СтроковыеСведения.СоставСемьи = СтрокаСоставСемьи(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьСпециальности(СтроковыеСведения)
	СтроковыеСведения.Специальности = СтрокаСпециальности(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

Функция ОбновитьТрудовуюДеятельность(СтроковыеСведения)
	СтроковыеСведения.ТрудоваяДеятельность = СтрокаТрудоваяДеятельность(СтроковыеСведения.ФизическоеЛицо);
КонецФункции

#Область Документы

Функция СтрокаДокументы(ФизическоеЛицо)
	СтрокаДокументы = "";
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	&ФизическоеЛицо КАК ФизЛицо,
	|	&Период КАК Период
	|ПОМЕСТИТЬ ВТФизическиеЛицаПериоды";
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Запрос.УстановитьПараметр("Период", '00010101');
	Запрос.Выполнить();
	
	ПараметрыПостроения = ЗарплатаКадрыОбщиеНаборыДанных.ПараметрыПостроенияДляСоздатьВТИмяРегистраСрез();
	ПараметрыПостроения.ФормироватьСПериодичностьДень = Ложь;
	ОписаниеФильтра = ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра("ВТФизическиеЛицаПериоды", "ФизЛицо");
	ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистраСрезПоследних("ДокументыФизическихЛиц", Запрос.МенеджерВременныхТаблиц, Истина, ОписаниеФильтра, ПараметрыПостроения);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДокументыФизическихЛиц.Представление
	|ИЗ
	|	ВТДокументыФизическихЛицСрезПоследних КАК ДокументыФизическихЛиц";
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			СтрокаДокументы = СтрокаДокументы + Выборка.Представление + Символы.ПС;
		КонецЦикла;	
	КонецЕсли;
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаДокументы);
	
	Возврат СтрокаДокументы;
КонецФункции 

#КонецОбласти 

#Область ЗнаниеЯзыков

Функция СтрокаЗнаниеЯзыков(ФизическоеЛицо)
	СтрокаЗнаниеЯзыков = РегистрыСведений.ЗнаниеЯзыковФизическихЛиц.ПредставлениеВладениеЯзыкамиФизическогоЛица(ФизическоеЛицо);	
	Возврат СтрокаЗнаниеЯзыков;
КонецФункции 

#КонецОбласти 

#Область Награды

Функция СтрокаНаграды(ФизическоеЛицо)
	СтрокаНаграды = "";
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НаградыФизическихЛиц.Награда,
	|	НаградыФизическихЛиц.НомерПриказа,
	|	НаградыФизическихЛиц.ДатаПриказа,
	|	НаградыФизическихЛиц.НаименованиеПриказа
	|ИЗ
	|	РегистрСведений.НаградыФизическихЛиц КАК НаградыФизическихЛиц
	|ГДЕ
	|	НаградыФизическихЛиц.ФизическоеЛицо = &ФизическоеЛицо
	|
	|УПОРЯДОЧИТЬ ПО
	|	НаградыФизическихЛиц.НомерПоПорядку";
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			СтрокаНаграды = СтрокаНаграды + ПредставлениеНаграды(Выборка) + Символы.ПС;
		КонецЦикла;	
	КонецЕсли;
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаНаграды);
	
	Возврат СтрокаНаграды;
КонецФункции 

Функция ПредставлениеНаграды(Награда)
	ПредставлениеНаграды = НСтр("ru = '%1, %2 №%3 от %4'");
	ПредставлениеНаграды = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ПредставлениеНаграды, Награда.Награда, Награда.НаименованиеПриказа, Награда.НомерПриказа, Формат(Награда.ДатаПриказа, "ДЛФ=DD"));
	Возврат ПредставлениеНаграды;
КонецФункции

#КонецОбласти 

#Область Обучение

Функция ДанныеОбОбучении(ФизическоеЛицо)
	
	ДанныеОбОбразовании = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОбразованиеФизическихЛиц.ВидОбразования КАК ВидОбразования,
	|	ОбразованиеФизическихЛиц.ВидПослевузовскогоОбразования КАК ВидПослевузовскогоОбразования,
	|	ОбразованиеФизическихЛиц.УчебноеЗаведение КАК УчебноеЗаведение,
	|	ОбразованиеФизическихЛиц.Специальность КАК Специальность,
	|	ОбразованиеФизическихЛиц.ВидДокумента КАК ВидДокумента,
	|	ОбразованиеФизическихЛиц.Серия КАК Серия,
	|	ОбразованиеФизическихЛиц.Номер КАК Номер,
	|	ОбразованиеФизическихЛиц.ДатаВыдачи КАК ДатаВыдачи,
	|	ОбразованиеФизическихЛиц.Квалификация КАК Квалификация,
	|	ОбразованиеФизическихЛиц.Начало КАК Начало,
	|	ОбразованиеФизическихЛиц.Окончание КАК Окончание,
	|	ОбразованиеФизическихЛиц.НаименованиеКурса КАК НаименованиеКурса,
	|	ОбразованиеФизическихЛиц.КоличествоЧасов КАК КоличествоЧасов,
	|	ОбразованиеФизическихЛиц.ВидДополнительногоОбучения КАК ВидДополнительногоОбучения
	|ИЗ
	|	Справочник.ОбразованиеФизическихЛиц КАК ОбразованиеФизическихЛиц
	|ГДЕ
	|	ОбразованиеФизическихЛиц.Владелец = &ФизическоеЛицо
	|	И НЕ ОбразованиеФизическихЛиц.ПометкаУдаления";
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		ДанныеОбОбразовании = Результат.Выбрать();
	КонецЕсли;
	
	Возврат ДанныеОбОбразовании;
	
КонецФункции	

Функция ДанныеОбОбученииЗаполнены(ДанныеОбОбразовании)
	
	Возврат ДанныеОбОбразовании <> Неопределено;	
	
КонецФункции

Функция ПредставлениеПериодаОбучения(Результат, УчебноеЗаведение, ДатаНачала, ДатаОкончания)

	ПредставлениеПериодаОбучения = "";
	
	ПараметрыПодстановки = Новый Массив;
	ПараметрыПодстановки.Добавить(Результат);
	ПараметрыПодстановки.Добавить(УчебноеЗаведение);
	ПараметрыПодстановки.Добавить(Формат(ДатаНачала, "ДЛФ=D"));
	ПараметрыПодстановки.Добавить(Формат(ДатаОкончания, "ДЛФ=D"));
	
	Если ЗначениеЗаполнено(Результат) Тогда
		ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + "%1";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(УчебноеЗаведение) Тогда
		Если НЕ ПустаяСтрока(ПредставлениеПериодаОбучения) Тогда
			ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + ", ";
		КонецЕсли;
		ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + "%2";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ДатаНачала)
		И ЗначениеЗаполнено(ДатаОкончания) Тогда
		ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + " (%3 - %4)";
	ИначеЕсли ЗначениеЗаполнено(ДатаНачала) Тогда
		ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + НСтр("ru = ' (с %3)'");
	ИначеЕсли ЗначениеЗаполнено(ДатаОкончания) Тогда
		ПредставлениеПериодаОбучения = ПредставлениеПериодаОбучения + НСтр("ru = ' (по %4)'");
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ПредставлениеПериодаОбучения) Тогда
		ПредставлениеПериодаОбучения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтрокуИзМассива(ПредставлениеПериодаОбучения, ПараметрыПодстановки); 
	КонецЕсли;
	
	Возврат ПредставлениеПериодаОбучения;
	
КонецФункции

#Область Образование

Функция СтрокаОбразование(ДанныеОбОбучении)
	
	СтрокаОбразование = "";
	
	ДанныеОбОбучении.Сбросить();
	
	Пока ДанныеОбОбучении.Следующий() Цикл
		Если ЭтоДанныеОбОбразовании(ДанныеОбОбучении) Тогда
			СтрокаОбразование = СтрокаОбразование + ПредставлениеОбразования(ДанныеОбОбучении) + Символы.ПС;
		КонецЕсли;
	КонецЦикла;	
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаОбразование);
	
	Возврат СтрокаОбразование;
	
КонецФункции

Функция ПредставлениеОбразования(Образование)
	Возврат ПредставлениеПериодаОбучения(Образование.Специальность, Образование.УчебноеЗаведение, Образование.Начало, Образование.Окончание);
КонецФункции	

Функция ЭтоДанныеОбОбразовании(ДанныеОбОбучении)
	Возврат ДанныеОбОбучении.ВидДополнительногоОбучения = Перечисления.ВидыПрофессиональнойПодготовки.ПустаяСсылка()
		Или ДанныеОбОбучении.ВидДополнительногоОбучения = Перечисления.ВидыПрофессиональнойПодготовки.Подготовка;
КонецФункции 

#КонецОбласти

#Область ПовышениеКвалификации

Функция СтрокаПовышениеКвалификации(ДанныеОбОбучении)
	
	СтрокаПовышениеКвалификации = "";
	
	ДанныеОбОбучении.Сбросить();
	
	Пока ДанныеОбОбучении.Следующий() Цикл
		Если ЭтоДанныеОПовышенииКвалификации(ДанныеОбОбучении) Тогда
			СтрокаПовышениеКвалификации = СтрокаПовышениеКвалификации + ПредставлениеПовышенияКвалификации(ДанныеОбОбучении) + Символы.ПС;
		КонецЕсли;
	КонецЦикла;	
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаПовышениеКвалификации);
	
	Возврат СтрокаПовышениеКвалификации;
	
КонецФункции

Функция ПредставлениеПовышенияКвалификации(ПовышениеКвалификации)
	Возврат ПредставлениеПериодаОбучения(ПовышениеКвалификации.Квалификация, ПовышениеКвалификации.УчебноеЗаведение, ПовышениеКвалификации.Начало, ПовышениеКвалификации.Окончание);
КонецФункции

Функция ЭтоДанныеОПовышенииКвалификации(ДанныеОбОбучении)
	Возврат ДанныеОбОбучении.ВидДополнительногоОбучения = Перечисления.ВидыПрофессиональнойПодготовки.ПовышениеКвалификации;
КонецФункции 

#КонецОбласти 

#Область Переподготовка

Функция СтрокаПереподготовка(ДанныеОбОбучении)
	
	СтрокаПереподготовка = "";
	
	ДанныеОбОбучении.Сбросить();
	
	Пока ДанныеОбОбучении.Следующий() Цикл
		Если ЭтоДанныеОПереподготовке(ДанныеОбОбучении) Тогда
			СтрокаПереподготовка = СтрокаПереподготовка + ПредставлениеПереподготовки(ДанныеОбОбучении) + Символы.ПС;
		КонецЕсли;
	КонецЦикла;	
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаПереподготовка);
	
	Возврат СтрокаПереподготовка;
	
КонецФункции

Функция ЭтоДанныеОПереподготовке(ДанныеОбОбучении)
	Возврат ДанныеОбОбучении.ВидДополнительногоОбучения = Перечисления.ВидыПрофессиональнойПодготовки.Переподготовка;
КонецФункции 

Функция ПредставлениеПереподготовки(Переподготовка)
	Возврат ПредставлениеПериодаОбучения(Переподготовка.Специальность, Переподготовка.УчебноеЗаведение, Переподготовка.Начало, Переподготовка.Окончание);
КонецФункции

#КонецОбласти 

#КонецОбласти 

#Область Профессии

Функция СтрокаПрофессии(ФизическоеЛицо)
	СтрокаПрофессии = РегистрыСведений.ПрофессииФизическихЛиц.ПредставлениеПрофессийФизическогоЛица(ФизическоеЛицо);	
	Возврат СтрокаПрофессии;
КонецФункции 

#КонецОбласти 

#Область СоставСемьи

Функция СтрокаСоставСемьи(ФизическоеЛицо)
	СтрокаСоставСемьи = "";
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	РодственникиФизическихЛиц.СтепеньРодства КАК СтепеньРодства,
	|	РодственникиФизическихЛиц.Наименование КАК ФИО,
	|	РодственникиФизическихЛиц.ДатаРождения КАК ДатаРождения
	|ИЗ
	|	Справочник.РодственникиФизическихЛиц КАК РодственникиФизическихЛиц
	|ГДЕ
	|	РодственникиФизическихЛиц.Владелец = &ФизическоеЛицо
	|	И НЕ РодственникиФизическихЛиц.СкрыватьВТ2
	|	И НЕ РодственникиФизическихЛиц.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	РодственникиФизическихЛиц.ДатаРождения УБЫВ";
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			СтрокаСоставСемьи = СтрокаСоставСемьи + ПредставлениеЧленаСемьи(Выборка) + Символы.ПС;
		КонецЦикла;	
	КонецЕсли;
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаСоставСемьи);
	
	Возврат СтрокаСоставСемьи;
КонецФункции

Функция ПредставлениеЧленаСемьи(ЧленСемьи)
	
	Если ЗначениеЗаполнено(ЧленСемьи.СтепеньРодства) Тогда
		
		ПредставлениеЧленаСемьи = "%1: %2";
		ПредставлениеЧленаСемьи = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ПредставлениеЧленаСемьи, ЧленСемьи.СтепеньРодства, ЧленСемьи.ФИО);
		
	Иначе
		
		ПредставлениеЧленаСемьи = "%1";
		ПредставлениеЧленаСемьи = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ПредставлениеЧленаСемьи, ЧленСемьи.ФИО);
		
	КонецЕсли;
	
	Возврат ПредставлениеЧленаСемьи;
	
КонецФункции

#КонецОбласти 

#Область Специальности

Функция СтрокаСпециальности(ФизическоеЛицо)
	СтрокаСпециальности = РегистрыСведений.СпециальностиФизическихЛиц.ПредставлениеСпециальностейФизическогоЛица(ФизическоеЛицо);
	Возврат СтрокаСпециальности;
КонецФункции 

#КонецОбласти 

#Область ТрудоваяДеятельность

Функция СтрокаТрудоваяДеятельность(ФизическоеЛицо)
	СтрокаТрудоваяДеятельность = "";
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТрудоваяДеятельностьФизическихЛиц.Организация,
	|	ТрудоваяДеятельностьФизическихЛиц.ДатаНачала,
	|	ТрудоваяДеятельностьФизическихЛиц.ДатаОкончания,
	|	ТрудоваяДеятельностьФизическихЛиц.Должность
	|ИЗ
	|	РегистрСведений.ТрудоваяДеятельностьФизическихЛиц КАК ТрудоваяДеятельностьФизическихЛиц
	|ГДЕ
	|	ТрудоваяДеятельностьФизическихЛиц.ФизическоеЛицо = &ФизическоеЛицо
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТрудоваяДеятельностьФизическихЛиц.НомерПоПорядку";
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			СтрокаТрудоваяДеятельность = СтрокаТрудоваяДеятельность + ПредставлениеМестаРаботы(Выборка) + Символы.ПС;
		КонецЦикла;	
	КонецЕсли;
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(СтрокаТрудоваяДеятельность);
	
	Возврат СтрокаТрудоваяДеятельность;
КонецФункции 

Функция ПредставлениеМестаРаботы(МестоРаботы)
	ПредставлениеМестаРаботы = "%1, %2, с %3 по %4";
	ПредставлениеМестаРаботы = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ПредставлениеМестаРаботы, МестоРаботы.Организация, МестоРаботы.Должность, Формат(МестоРаботы.ДатаНачала, "ДЛФ=D"), Формат(МестоРаботы.ДатаОкончания, "ДЛФ=D"));
	Возврат ПредставлениеМестаРаботы;
КонецФункции

#КонецОбласти 

Функция ФизическиеЛицаБезСтроковыхСведений()
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1000
	|	ФизическиеЛица.Ссылка КАК ФизическоеЛицо
	|ИЗ
	|	Справочник.ФизическиеЛица КАК ФизическиеЛица
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтроковыеСведенияФизическихЛиц КАК СтроковыеСведенияФизическихЛиц
	|		ПО (СтроковыеСведенияФизическихЛиц.ФизическоеЛицо = ФизическиеЛица.Ссылка)
	|ГДЕ
	|	СтроковыеСведенияФизическихЛиц.ФизическоеЛицо ЕСТЬ NULL ";
	Результат = Запрос.Выполнить();
	
	Выборка = Неопределено;
	
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
	КонецЕсли;
	
	Возврат Выборка;
	
КонецФункции

Функция ОбновлениеСтроковыхСведенийЗавершено(ФизическиеЛица)
	Возврат ФизическиеЛица = Неопределено;
КонецФункции 

Процедура ЗаполнитьСтроковыеСведенияФизическихЛиц(ВыборкаФизическиеЛица, ПричинаОбновления = Неопределено)
	
	Пока ВыборкаФизическиеЛица.Следующий() Цикл
		ЗаполнитьСтроковыеСведенияФизическогоЛица(ВыборкаФизическиеЛица.ФизическоеЛицо, ПричинаОбновления)
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьСтроковыеСведенияФизическогоЛица(ФизическоеЛицо, ПричинаОбновления = Неопределено)
	
	НачатьТранзакцию();
	
	Попытка
		
		ЗаблокироватьСтроковыеСведенияФизическогоЛица(ФизическоеЛицо);
		
		ОбновитьСтроковыеСведенияФизическогоЛица(ФизическоеЛицо, ПричинаОбновления);
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ЗаписатьОшибкуОбновленияСтроковыхСведений(ФизическоеЛицо);
		
	КонецПопытки;
	
КонецПроцедуры

Процедура ЗаблокироватьСтроковыеСведенияФизическогоЛица(ФизическоеЛицо)
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.СтроковыеСведенияФизическихЛиц");
	ЭлементБлокировки.УстановитьЗначение("ФизическоеЛицо", ФизическоеЛицо);
	Блокировка.Заблокировать();
	
КонецПроцедуры

Процедура ЗаписатьОшибкуОбновленияСтроковыхСведений(ФизическоеЛицо)
	
	Причина = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	
	ТекстСообщения = НСтр("ru = 'Не удалось обработать %1 по причине: %2'");
	ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ФизическоеЛицо, Причина);  
	
	СобытиеЖурнала = ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации();
	УровеньЖурнала = УровеньЖурналаРегистрации.Предупреждение;
	
	ЗаписьЖурналаРегистрации(СобытиеЖурнала, УровеньЖурнала, ФизическоеЛицо.Метаданные(), ФизическоеЛицо, ТекстСообщения);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
