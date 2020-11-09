#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьФизическиеЛицаПоВедомостям();
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Для Каждого ПараметрЗаполнения Из ДанныеЗаполнения Цикл
			Если ПараметрЗаполнения.Ключ = "Ведомости" Тогда
				Если ПараметрЗаполнения.Значение.Количество() = 1 И ОбменСБанкамиПоЗарплатнымПроектам.РазрешенаОтправкаОтдельнойВедомости() Тогда
					ТекстОшибки = НСтр("ru = 'Платежное поручение предназначено для группировки нескольких ведомостей с целью формирования единого реестра на зачисление зарплаты и отправки его в банк одним файлом.
										|Ввод платежного поручения никак не влияет на отражение факта выплаты зарплаты в программе. 
										|Создание платежного поручения имеет смысл только для более чем одной ведомости.'");
					ВызватьИсключение ТекстОшибки;
				КонецЕсли;
				
				Для Каждого ЗначениеЗаполнения Из ПараметрЗаполнения.Значение Цикл
					НоваяСтрокаСостава = Ведомости.Добавить();
					НоваяСтрокаСостава.Ведомость = ЗначениеЗаполнения;
					Если ЗначениеЗаполнено(Организация) Тогда
						Если Организация <> ЗначениеЗаполнения.Организация Тогда
							ТекстОшибки = НСтр("ru = 'Платежное поручение предназначено для группировки нескольких ведомостей с целью формирования единого реестра по одной организации.'");
							ВызватьИсключение ТекстОшибки;
						КонецЕсли;
					Иначе
						Организация = ЗначениеЗаполнения.Организация;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НепроверяемыеРеквизиты = Новый Массив;
	
	// в старых документах вид дохода не обязателен
	Если Не Документы.ПлатежноеПоручение.ВидДоходаИсполнительногоПроизводстваОбязателен(ЭтотОбъект) Тогда
		НепроверяемыеРеквизиты.Добавить("ВидДоходаИсполнительногоПроизводства");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	
	МассивВедомостей = Новый Массив;
	СоответствиеВедомостей = Новый Соответствие;
	Для каждого СтрокаДокумента Из Ведомости Цикл
		СоответствиеВедомостей.Вставить(СтрокаДокумента.Ведомость, СтрокаДокумента.НомерСтроки - 1);
		МассивВедомостей.Добавить(СтрокаДокумента.Ведомость);
	КонецЦикла;
	
	МассивОшибок = Новый Массив;
	ОбменСБанкамиПоЗарплатнымПроектам.ПроверитьЗаполнениеПлатежногоДокумента(Ссылка, МассивВедомостей, МассивОшибок);
	
	Для Каждого Ошибка Из МассивОшибок Цикл
		ИмяПоля = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("Ведомости[%1].Ведомость", СоответствиеВедомостей.Получить(Ошибка.Ведомость));
		ОбщегоНазначения.СообщитьПользователю(Ошибка.ТекстСообщения, ЭтотОбъект, ИмяПоля, , Отказ);
	КонецЦикла;
	
	Если Не Отказ Тогда
		ДополнительныеСвойства.Вставить("ПроверкаВыполнена", Истина);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	НомерРеестра = 0;
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает признак изменения данных, влияющих на формирование электронного документа.
// 
Функция ИзменилисьКлючевыеРеквизитыЭлектронногоДокумента() Экспорт
	
	ИзменилисьКлючевыеРеквизиты = 
		ЭлектронноеВзаимодействиеБЗК.ИзменилисьРеквизитыОбъекта(ЭтотОбъект, "Дата, Номер, Организация, НомерРеестра, ПометкаУдаления")	
		Или ЭлектронноеВзаимодействиеБЗК.ИзмениласьТабличнаяЧастьОбъекта(ЭтотОбъект, "Ведомости", "Ведомость");
		
	Возврат ИзменилисьКлючевыеРеквизиты;
	
КонецФункции

// Добавляет в документ указанные ведомости.
// Параметры:
// 		ДобавляемыеВедомости - Массив из ДокументСсылка - добавляемые ведомости
// 
Процедура ДобавитьВедомости(ДобавляемыеВедомости) Экспорт
	
	Для Каждого Ведомость Из ДобавляемыеВедомости Цикл
		Если Ведомости.Найти(Ведомость, "Ведомость") = Неопределено Тогда
			НоваяСтрока = Ведомости.Добавить();
			НоваяСтрока.Ведомость = Ведомость;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры	

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьФизическиеЛицаПоВедомостям()
	
	ФизическиеЛица.Очистить();
	
	Если Ведомости.Количество() > 0 Тогда
		
		ФизлицаВедомостей = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(
			Ведомости.ВыгрузитьКолонку("Ведомость"), 
			"ФизическиеЛица");
			
		ФизическиеЛицаВедомостей = Новый Массив;
		Для Каждого ФизлицаВедомости Из ФизлицаВедомостей Цикл
			Если Не ФизлицаВедомости.Значение.Пустой() Тогда
				ОбщегоНазначенияКлиентСервер.ДополнитьМассив(
					ФизическиеЛицаВедомостей,
					ФизлицаВедомости.Значение.Выгрузить().ВыгрузитьКолонку("ФизическоеЛицо"));
			КонецЕсли;
		КонецЦикла;	
		
		Для Каждого ФизическоеЛицо Из ОбщегоНазначенияКлиентСервер.СвернутьМассив(ФизическиеЛицаВедомостей) Цикл
			ФизическиеЛица.Добавить().ФизическоеЛицо = ФизическоеЛицо
		КонецЦикла	
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли