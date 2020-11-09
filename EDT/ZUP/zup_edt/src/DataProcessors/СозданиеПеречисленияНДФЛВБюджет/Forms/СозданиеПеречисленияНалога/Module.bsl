
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИспользоватьСтатьиФинансирования 	= ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиФинансированияЗарплатаРасширенный");
	ИспользоватьСтатьиРасходов 			= ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении");
	ВРазрезеИсточников = ИспользоватьСтатьиФинансирования;
	
	Если Параметры.Свойство("ДокументОснование", ДокументОснование) Тогда
		
		Если НельзяСоздатьПеречислениеПоДокументу() Тогда
			Отказ = Истина;
			Возврат;
		КонецЕсли;
		
		Организация = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументОснование, "Организация");
		ЗаполнитьСписокДокументов();
		ДатаДокументов = ТекущаяДатаСеанса();
		
	Иначе
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	// Управление детализацией доступно если разрешено не заполнять Статью финансирования.
	ПроверкаЗаполненияФинансирования = Новый ФиксированнаяСтруктура(Документы.ПеречислениеНДФЛВБюджет.РежимПроверкиЗаполненияФинансирования());
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы,
				"ВРазрезеИсточников",
				"Видимость",
				Не ПроверкаЗаполненияФинансирования.СтатьяФинансирования);
				
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы,
				"СписокДокументовСтатьяРасходов",
				"АвтоОтметкаНезаполненного",
				ПроверкаЗаполненияФинансирования.СтатьяРасходов);
				
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы,
				"СписокДокументовСтатьяФинансирования",
				"АвтоОтметкаНезаполненного",
				ПроверкаЗаполненияФинансирования.СтатьяФинансирования);
				
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Объект.СписокДокументов.Количество() = 1 Тогда
		
		ДанныеДляЗаполнения = Новый Структура("
		|Ведомость,
		|Организация,
		|РегистрацияВНалоговомОргане,
		|СтатьяФинансирования,
		|СтатьяРасходов,
		|Сумма");
		ЗаполнитьЗначенияСвойств(ДанныеДляЗаполнения, Объект.СписокДокументов[0]);
		ДанныеДляЗаполнения.Организация = Организация;
		ДанныеДляЗаполнения.Ведомость = ДокументОснование;
		
		ПараметрыЗаполнения = Новый Структура;
		ПараметрыЗаполнения.Вставить("ДанныеДляЗаполнения", ДанныеДляЗаполнения);
		
		ОткрытьФорму("Документ.ПеречислениеНДФЛВБюджет.Форма.ФормаДокумента", ПараметрыЗаполнения);
		
		Отказ = Истина;
		Возврат;
		
	КонецЕсли;

КонецПроцедуры


#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВРазрезеИсточниковПриИзменении(Элемент)
	
	ЗаполнитьСписокДокументов();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПровестиДокументы(Команда)
	
	ОчиститьСообщения();
	
	Если ПровестиДокументыНаСервере() Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокДокументов()

	Объект.СписокДокументов.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", ДокументОснование);
	Запрос.УстановитьПараметр("ИспользоватьСтатьиФинансирования", ВРазрезеИсточников И ИспользоватьСтатьиФинансирования);
	Запрос.УстановитьПараметр("ИспользоватьСтатьиРасходов", ВРазрезеИсточников И ИспользоватьСтатьиРасходов);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НДФЛКПеречислению.Организация КАК Организация,
	|	НДФЛКПеречислению.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	ВЫБОР
	|		КОГДА &ИспользоватьСтатьиФинансирования
	|			ТОГДА НДФЛКПеречислению.СтатьяФинансирования
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка)
	|	КОНЕЦ КАК СтатьяФинансирования,
	|	ВЫБОР
	|		КОГДА &ИспользоватьСтатьиРасходов
	|			ТОГДА НДФЛКПеречислению.СтатьяРасходов
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка)
	|	КОНЕЦ КАК СтатьяРасходов,
	|	СУММА(НДФЛКПеречислению.Сумма) КАК Сумма
	|ИЗ
	|	РегистрНакопления.НДФЛКПеречислению КАК НДФЛКПеречислению
	|ГДЕ
	|	НДФЛКПеречислению.Регистратор = &Регистратор
	|
	|СГРУППИРОВАТЬ ПО
	|	НДФЛКПеречислению.Организация,
	|	ВЫБОР
	|		КОГДА &ИспользоватьСтатьиРасходов
	|			ТОГДА НДФЛКПеречислению.СтатьяРасходов
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка)
	|	КОНЕЦ,
	|	НДФЛКПеречислению.РегистрацияВНалоговомОргане,
	|	ВЫБОР
	|		КОГДА &ИспользоватьСтатьиФинансирования
	|			ТОГДА НДФЛКПеречислению.СтатьяФинансирования
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка)
	|	КОНЕЦ";
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.СписокДокументов.Добавить(), Выборка);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция ПровестиДокументыНаСервере()
	
	// Проверим заполнение строк.
	
	КонтейнерОшибок = Неопределено;
	ЕстьОшибки = Ложь;
	Для каждого СтрокаТЧ Из Объект.СписокДокументов Цикл
		
		Для каждого ЭлементФинансирования Из ПроверкаЗаполненияФинансирования Цикл
			Если ЭлементФинансирования.Значение И Не ЗначениеЗаполнено(СтрокаТЧ[ЭлементФинансирования.Ключ]) Тогда
				ТекстСообщения = НСтр("ru = 'В строке %1 не заполнено Финансирование.'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, СтрокаТЧ.НомерСтроки);
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(КонтейнерОшибок,
					"Объект.СписокДокументов[%1]." + ЭлементФинансирования.Ключ,
					ТекстСообщения, "", СтрокаТЧ.НомерСтроки,,СтрокаТЧ.НомерСтроки-1);
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если Не ЗначениеЗаполнено(СтрокаТЧ.ДатаПлатежа) Тогда
			ТекстСообщения = НСтр("ru = 'В строке %1 не заполнена Дата платежа.'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, СтрокаТЧ.НомерСтроки);
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(КонтейнерОшибок,
					"Объект.СписокДокументов[%1].ДатаПлатежа",
					ТекстСообщения, "", СтрокаТЧ.НомерСтроки,,СтрокаТЧ.НомерСтроки-1);	
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(СтрокаТЧ.Сумма) Тогда
			ТекстСообщения = НСтр("ru = 'В строке %1 не заполнена Сумма.'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, СтрокаТЧ.НомерСтроки);
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(КонтейнерОшибок,
					"Объект.СписокДокументов[%1].Сумма",
					ТекстСообщения, "", СтрокаТЧ.НомерСтроки,,СтрокаТЧ.НомерСтроки-1);	
		КонецЕсли;
		
	КонецЦикла;
	
	Если КонтейнерОшибок <> Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(КонтейнерОшибок);
		Возврат Ложь;
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Для Каждого СтрокаТЧ Из Объект.СписокДокументов Цикл
		
		ДанныеДляЗаполнения = Новый Структура("
		|Дата,
		|Ведомость,
		|Организация,
		|РегистрацияВНалоговомОргане,
		|СтатьяФинансирования,
		|СтатьяРасходов,
		|ДатаПлатежа,
		|ПлатежноеПоручениеНомер,
		|ПлатежноеПоручениеДата,
		|Сумма");
		ЗаполнитьЗначенияСвойств(ДанныеДляЗаполнения, СтрокаТЧ);
		ДанныеДляЗаполнения.Организация = Организация;
		ДанныеДляЗаполнения.Ведомость 	= ДокументОснование;
		ДанныеДляЗаполнения.Дата 		= ДатаДокументов;
		
		ПараметрыЗаполнения = Новый Структура;
		ПараметрыЗаполнения.Вставить("ЗаполнениеПоВедомости", ДанныеДляЗаполнения);
		
		НовыйДокумент = Документы.ПеречислениеНДФЛВБюджет.СоздатьДокумент();
		НовыйДокумент.Заполнить(ПараметрыЗаполнения);
		НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение);
		
	КонецЦикла;
	
	ЗафиксироватьТранзакцию();

	
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Функция НельзяСоздатьПеречислениеПоДокументу()
	
	Если Не ЗначениеЗаполнено(ДокументОснование) Или НЕ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументОснование, "Проведен") Тогда
		ТекстСообщения = НСтр("ru = 'Ввести перечисление НДФЛ возможно только по проведенному документу'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;

КонецФункции

#КонецОбласти