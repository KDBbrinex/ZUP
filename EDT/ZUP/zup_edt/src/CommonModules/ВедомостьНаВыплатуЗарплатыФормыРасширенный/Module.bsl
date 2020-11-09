////////////////////////////////////////////////////////////////////////////////
// Ведомости на выплату зарплаты.
// Расширенные серверные процедуры и функции форм документов.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

#Область РедактированиеСтрокиВедомости

Процедура РедактированиеЗарплатыСтрокиНастроитьЭлементы(Форма) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы, 
		"ЗарплатаСтатьяРасходов", 
		"Видимость", 
		Истина);
	
	ПолеСотрудника = Форма.Элементы.ЗарплатаСотрудник;
	
	ПараметрВыбораПоказыватьДоговорниковГПХ = Новый ПараметрВыбора("Отбор.ПоказыватьДоговорниковГПХ", Истина);	
	
	ДобавитьПоказДоговорников = Истина;
	Для Каждого ПараметрВыбора Из ПолеСотрудника.ПараметрыВыбора Цикл
		Если ПараметрВыбора.Имя = ПараметрВыбораПоказыватьДоговорниковГПХ.Имя Тогда
			ПараметрВыбора.Значение = ПараметрВыбораПоказыватьДоговорниковГПХ.Значение;
			ДобавитьПоказДоговорников = Ложь;
			Прервать
		КонецЕсли;	
	КонецЦикла;	
	
	Если ДобавитьПоказДоговорников Тогда
		ПараметрыВыбора = Новый Массив(ПолеСотрудника.ПараметрыВыбора);
		ПараметрыВыбора.Добавить(ПараметрВыбораПоказыватьДоговорниковГПХ);
		ПолеСотрудника.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
	КонецЕсли;	
				
КонецПроцедуры

Процедура РедактированиеНДФЛСтрокиНастроитьЭлементы(Форма) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"НДФЛСтатьяРасходов",
		"Видимость",
		Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ФормаДокумента

#Область ОбработчикиСобытийФормы

// Обработчик события ПриСозданииНаСервере.
// 	Устанавливает первоначальные значения реквизитов объекта.
//	Инициализирует реквизиты формы.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма, которая создается.
// 	Отказ - Булево - признак отказа от создания формы.
// 	СтандартнаяОбработка - Булево - признак выполнения стандартной обработки события.
//
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ВедомостьНаВыплатуЗарплатыФормы.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
	
	// Настройка полей статей расходов
	НастроитьПоляСтатьиРасходов(Форма);
	
	// Установка обязательности полей финансирования
	ОбщегоНазначенияБЗККлиентСервер.УстановитьОбязательностьПоляВводаФормы(
		Форма, 
		"СтатьяФинансирования", 
		ВедомостьНаВыплатуЗарплатыРасширенный.СтатьяФинансированияОбязательна());
	ОбщегоНазначенияБЗККлиентСервер.УстановитьОбязательностьПоляВводаФормы(
		Форма, 
		?(ПолучитьФункциональнуюОпцию("РаботаВХозрасчетнойОрганизации"),
			"СпособРасчетов",
			"СтатьяРасходов"), 
		ВедомостьНаВыплатуЗарплатыРасширенный.СтатьяРасходовОбязательна());
	
	// Настройка полей оплаты ведомостей и перечисления налогов
	Если ПолучитьФункциональнуюОпцию("ИспользоватьВнешниеХозяйственныеОперацииЗарплатаКадры") Тогда
		
		Форма.Элементы.ОплатыПредставление.Видимость   = Ложь;
		Форма.Элементы.ВнешниеОперацииГруппа.Видимость = Истина;
		
		ВестиРасчетыСБюджетомПоНДФЛ = ПолучитьФункциональнуюОпцию("ВестиРасчетыСБюджетомПоНДФЛ");
		Если Форма.Параметры.Ключ.Пустая() И ВестиРасчетыСБюджетомПоНДФЛ Тогда
			Форма.Объект.ПеречислениеНДФЛВыполнено = Ложь;
		КонецЕсли;
		
		ПоказыватьВводДокументаПеречисленияНДФЛ = Ложь;
		Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ВнешниеХозяйственныеОперации.УчетНДФЛВХО") Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("УчетНДФЛВХО");
			ПоказыватьВводДокументаПеречисленияНДФЛ = Модуль.ПоказыватьВводДокументаПеречисленияНДФЛ();
		КонецЕсли;
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, 
				"ВводДанныхОПеречисленииНДФЛ", "Видимость", ПоказыватьВводДокументаПеречисленияНДФЛ);
		
		// Вариант регистрации перечисления НДФЛ показывается, если
		// в документе уже указано, что налог перечислен или не ведется учет расчетов с бюджетом.
		ПоказыватьВариантПеречислениеНДФЛ = Форма.Объект.ПеречислениеНДФЛВыполнено Или Не ВестиРасчетыСБюджетомПоНДФЛ;
		Если Форма.ПоказыватьВариантПеречислениеНДФЛПрежняя = Неопределено Тогда
			Форма.ПоказыватьВариантПеречислениеНДФЛПрежняя = ПоказыватьВариантПеречислениеНДФЛ;
		Иначе
			ПоказыватьВариантПеречислениеНДФЛ = ПоказыватьВариантПеречислениеНДФЛ Или Форма.ПоказыватьВариантПеречислениеНДФЛПрежняя;
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, 
			"ПеречислениеНДФЛВыполнено", "Видимость", ПоказыватьВариантПеречислениеНДФЛ);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, 
			"ПеречислениеНДФЛПолностьюИнфо", "Видимость", ПоказыватьВариантПеречислениеНДФЛ);
		
		ВедомостьНаВыплатуЗарплатыКлиентСерверРасширенный.УстановитьОтображениеВХО(Форма);
		
	Иначе	
		Форма.Элементы.ОплатыПредставление.Видимость   = Истина;
		Форма.Элементы.ВнешниеОперацииГруппа.Видимость = Ложь;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

Процедура СпособВыплатыПриИзмененииНаСервере(Форма) Экспорт
	
	ПрежнийСпособВыплаты = Форма.РеквизитФормыВЗначение("СпособВыплаты");
	
	ВедомостьНаВыплатуЗарплатыФормы.СпособВыплатыПриИзмененииНаСервере(Форма);
	
	Если ПрежнийСпособВыплаты.ВидДокументаОснования <> Форма.СпособВыплаты.ВидДокументаОснования Тогда
		Форма.Объект.Основания.Очистить();
		УстановитьПредставлениеОснований(Форма); 
	КонецЕсли;	
	
	Если ПрежнийСпособВыплаты.ХарактерВыплаты <> Форма.СпособВыплаты.ХарактерВыплаты Тогда
		ВедомостьНаВыплатуЗарплатыКлиентСерверРасширенный.УстановитьОтображениеВХО(Форма, Ложь, Истина);
	КонецЕсли;	
	
	ЗаполнитьЗначенияСвойств(Форма.Объект, Форма.СпособВыплаты, "Округление, ПроцентВыплаты");
	
	УстановитьПредставлениеПараметровРасчета(Форма);
		
КонецПроцедуры

Процедура ПараметрыРасчетаПриИзменении(Форма) Экспорт
	УстановитьПредставлениеПараметровРасчета(Форма);
КонецПроцедуры

#КонецОбласти

Процедура НастроитьПоляСтатьиРасходов(Форма) Экспорт
	
	Если ПолучитьФункциональнуюОпцию("РаботаВХозрасчетнойОрганизации") Тогда
		
		Форма.Элементы.СтатьяРасходов.Видимость = Ложь;
		Форма.Элементы.СпособРасчетов.Видимость = Истина;
		
		СтатьиРасходов  = ЗарплатаКадры.СтатьиРасходовПоСпособамРасчетовСФизическимиЛицами();
		СпособыРасчетов = Перечисления.СпособыРасчетовСФизическимиЛицами.ДоступныеСпособыРасчетов("Ведомости");
		
		Форма.Элементы.СпособРасчетов.СписокВыбора.Очистить();
		Для Каждого СпособРасчетов Из СпособыРасчетов Цикл
			Форма.Элементы.СпособРасчетов.СписокВыбора.Добавить(
				СтатьиРасходов[СпособРасчетов], 
				Строка(СпособРасчетов));
		КонецЦикла;	
		
		Форма.Элементы.СпособРасчетов.КнопкаОчистки = Не ВедомостьНаВыплатуЗарплатыРасширенный.СтатьяРасходовОбязательна();
		
	ИначеЕсли ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении") Тогда	
		Форма.Элементы.СтатьяРасходов.Видимость = Истина;
		Форма.Элементы.СпособРасчетов.Видимость = Ложь;
	Иначе
		ВызватьИсключение НСтр("ru = 'Неверно настроены функциональные опции'");
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при создании формы новой ведомости.
// Выполняет заполнение первоначальных значений реквизитов ведомости в форме.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения.
//
Процедура ЗаполнитьПервоначальныеЗначения(Форма) Экспорт
	
	ВедомостьНаВыплатуЗарплатыФормы.ЗаполнитьПервоначальныеЗначения(Форма);
	
	Если НЕ ПолучитьФункциональнуюОпцию("ВыполнятьРасчетЗарплатыПоПодразделениям") Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
			Форма, "Объект.Подразделение", 
			Справочники.ПодразделенияОрганизаций.ПустаяСсылка());
	КонецЕсли;
	
	Если ВедомостьНаВыплатуЗарплатыРасширенный.СтатьяРасходовОбязательна() Тогда 
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
			Форма, "Объект.СтатьяРасходов", 
			ОтражениеЗарплатыВБухучетеРасширенный.СтатьяОплатаТруда(), Истина);
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
		Форма, "Объект.ПроцентВыплаты", 
		Форма.СпособВыплаты.ПроцентВыплаты, Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
		Форма, "Объект.ПроцентВыплаты", 
		100, Истина);
	
КонецПроцедуры

// Вызывается при получении формой данных объекта.
// Приспосабливает форму к редактируемым данным.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения.
//	ТекущийОбъект - ДокументОбъект - Объект, который будет прочитан. 
//
Процедура ПриПолученииДанныхНаСервере(Форма, ТекущийОбъект) Экспорт
	
	ВедомостьНаВыплатуЗарплатыФормы.ПриПолученииДанныхНаСервере(Форма, ТекущийОбъект);	
	
	УстановитьПредставлениеОснований(Форма); 
	УстановитьПредставлениеПараметровРасчета(Форма);
	
КонецПроцедуры

Процедура ПриПолученииДанныхСтрокиСостава(Форма, СтрокаСостава) Экспорт
	ВедомостьНаВыплатуЗарплатыФормы.ПриПолученииДанныхСтрокиСостава(Форма, СтрокаСостава);
	ПриПолученииДанныхСтрокиСоставаФинансирование(Форма, СтрокаСостава);
КонецПроцедуры	

Процедура ПриПолученииДанныхСтрокиСоставаФинансирование(Форма, СтрокаСостава)

	ПоказыватьСтатьиФинансирования = ПолучитьФункциональнуюОпцию("ИспользоватьСтатьиФинансированияЗарплата");
	ПоказыватьСтатьиРасходов       = ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении");
	
	Если Не ПоказыватьСтатьиФинансирования И Не ПоказыватьСтатьиРасходов Тогда
		СтрокаСостава.Финансирование = "";
		Возврат
	КонецЕсли;
	
	ПоляСтатей = Новый Массив;
	Если ПоказыватьСтатьиФинансирования Тогда 
		ПоляСтатей.Добавить("СтатьяФинансирования")
	КонецЕсли;
	Если ПоказыватьСтатьиРасходов Тогда
		ПоляСтатей.Добавить("СтатьяРасходов")
	КонецЕсли;
	ПоляСтатей = СтрСоединить(ПоляСтатей, ", ");
	
	СочетанияСтатей = Форма.Объект.Зарплата.Выгрузить(
		Новый Структура("ИдентификаторСтроки", СтрокаСостава.ИдентификаторСтроки), 
		ПоляСтатей);
	СочетанияСтатей.Свернуть(ПоляСтатей);
	
	Если ПоказыватьСтатьиФинансирования Тогда
		ПредставленияСтатейФинансирования = ВедомостьНаВыплатуЗарплатыФормыПовтИсп.ПредставленияСтатейФинансирования();
	КонецЕсли;
	Если ПоказыватьСтатьиРасходов Тогда
		ПредставленияСтатейРасходов = ВедомостьНаВыплатуЗарплатыФормыПовтИсп.ПредставленияСтатейРасходов();
	КонецЕсли;	
	
	РасшифровкаФинансирования = "";
	Для Индекс = 0 По СочетанияСтатей.Количество()-1 Цикл
		
		Если Индекс = 3 Тогда
			РасшифровкаФинансирования = РасшифровкаФинансирования + "...";
			Прервать
		ИначеЕсли Индекс > 0 Тогда
			РасшифровкаФинансирования = РасшифровкаФинансирования + Символы.ПС;
		КонецЕсли;

		Если ПоказыватьСтатьиФинансирования И ПоказыватьСтатьиРасходов Тогда
			РасшифровкаФинансирования = РасшифровкаФинансирования 
				+ СтрШаблон(
					"%1(%2)",
					ПредставленияСтатейФинансирования[СочетанияСтатей[Индекс].СтатьяФинансирования],
					ПредставленияСтатейРасходов[СочетанияСтатей[Индекс].СтатьяРасходов]);
		ИначеЕсли ПоказыватьСтатьиФинансирования Тогда
			РасшифровкаФинансирования = РасшифровкаФинансирования
				+ ПредставленияСтатейФинансирования[СочетанияСтатей[Индекс].СтатьяФинансирования];
		ИначеЕсли ПоказыватьСтатьиРасходов Тогда
			РасшифровкаФинансирования = РасшифровкаФинансирования 
				+ ПредставленияСтатейРасходов[СочетанияСтатей[Индекс].СтатьяРасходов];
		КонецЕсли;	
			
	КонецЦикла;	

	СтрокаСостава.Финансирование = РасшифровкаФинансирования;
	
КонецПроцедуры

// Обработка сообщений пользователю для форм ведомостей.
// 	Привязывает сообщения объекта к полям формы.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения.
//
Процедура ОбработатьСообщенияПользователю(Форма) Экспорт
	
	ВедомостьНаВыплатуЗарплатыФормы.ОбработатьСообщенияПользователю(Форма);
	
	Сообщения = ПолучитьСообщенияПользователю(Ложь);
	
	Для Каждого Сообщение Из Сообщения Цикл
		Если СтрНайти(Сообщение.Поле, "СтатьяРасходов") Тогда
			Сообщение.Текст = 
				СтрЗаменить(
					Сообщение.Текст,
					Метаданные.НайтиПоТипу(ТипЗнч(Форма.Объект.Ссылка)).Реквизиты.СтатьяРасходов.Синоним,
					ВедомостьНаВыплатуЗарплатыРасширенный.ПредставлениеРеквизитаСтатьяРасходов());
		КонецЕсли;
		Если СтрНайти(Сообщение.Поле, "ПроцентВыплаты") Тогда
			Сообщение.Поле = "";
			Сообщение.ПутьКДанным = "ПараметрыРасчетаИнфо";
		КонецЕсли;
		Если СтрНайти(Сообщение.Поле, "Основания") Тогда
			Сообщение.Поле = "";
			Сообщение.ПутьКДанным = "ОснованияПредставление";
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Устанавливает доступность элементов формы ведомости.
// 	Документ ввода начальных остатков, или по ведомость, по которой есть выплаты,
// или зарегистрирован перенос даты получения дохода
//	доступны только для просмотра.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения.
//
Процедура УстановитьДоступностьЭлементов(Форма) Экспорт
	
	ВедомостьНаВыплатуЗарплатыФормы.УстановитьДоступностьЭлементов(Форма);
	
	Форма.ТолькоПросмотр = Форма.ТолькоПросмотр 
			Или ЗарплатаКадрыПриложенияВызовСервера.ЕстьПодтверждениеВыплатыДоходовПоВедомости(Форма.Объект.Ссылка);
		
КонецПроцедуры

Процедура ОчиститьНаСервере(Форма) Экспорт
	
	ТекущийОбъект = Форма.РеквизитФормыВЗначение("Объект");
	
	ТекущийОбъект.ОчиститьВыплаты();
	
	Форма.ОбработатьСообщенияПользователю();
	
	Форма.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
	Форма.ПриПолученииДанныхНаСервере(ТекущийОбъект);	
	
КонецПроцедуры

Процедура УстановитьПредставлениеОснований(Форма)
	
	Если ЗначениеЗаполнено(Форма.СпособВыплаты.ВидДокументаОснования) Тогда
	
		Если Форма.Объект.Основания.Количество() = 0 Тогда
			Форма.ОснованияПредставление = НСтр("ru = 'Не выбраны'");
			Форма.ОснованияВыбраны = Ложь;
		Иначе	
			Форма.ОснованияПредставление = ЧислоПрописью(Форма.Объект.Основания.Количество(), , НСтр("ru = 'документ, документа, документов, м, ,,,,0'"));
			Форма.ОснованияВыбраны = Истина;
		КонецЕсли;	
		
	Иначе
		
		Форма.ОснованияПредставление = "";
		Форма.ОснованияВыбраны = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьПредставлениеПараметровРасчета(Форма)
	
	ПараметрыРасчета = 
		Новый Структура(
			"ПроцентВыплаты,
			|Округление",
			Форма.Объект.ПроцентВыплаты,
			Форма.Объект.Округление);
			
	ПредставлениеПараметровРасчета = ПредставлениеПараметровРасчета(ПараметрыРасчета);		
	
	Форма.Элементы.ПараметрыРасчетаГруппа.ЗаголовокСвернутогоОтображения =  ПредставлениеПараметровРасчета;
	
КонецПроцедуры

// Возвращает представление параметров расчета ведомости.
//
// Параметры:
// 	ПараметрыРасчета - Структура - параметры расчета:
//     * ПроцентВыплаты - Число - процент выплаты.
//     * Округление     - СправочникСсылка.СпособыОкругленияПриРасчетеЗарплаты - округление.	
//
Функция ПредставлениеПараметровРасчета(ПараметрыРасчета)
	
	ПредставлениеПараметровРасчета = "";
	
	// Проконтролируем сомнительные настройки.
	Если НЕ ЗначениеЗаполнено(ПараметрыРасчета.ПроцентВыплаты) ИЛИ ПараметрыРасчета.ПроцентВыплаты < 0 Тогда
		ТекстОшибки = 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'размер выплаты %1% ?'"), 
				ПараметрыРасчета.ПроцентВыплаты)
	Иначе
		ТекстОшибки = ""
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ТекстОшибки) Тогда
		
		ПредставлениеПараметровРасчета = 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Внимание. Проверьте настройки расчета: %1'"),  
				ТекстОшибки);
			
	Иначе
	
		// Штатная работа
	
		ПредставлениеПараметровРасчета = 
			СтрШаблон(НСтр("ru = 'Заполнение %1, %2'"),
			ПредставлениеПроцентаВыплаты(ПараметрыРасчета.ПроцентВыплаты),
			ПредставлениеОкругления(ПараметрыРасчета.Округление));
			
	КонецЕсли;
	
	Возврат ПредставлениеПараметровРасчета;
	
КонецФункции

Функция ПредставлениеПроцентаВыплаты(ПроцентВыплаты)
	
	Если ЗначениеЗаполнено(ПроцентВыплаты) И ПроцентВыплаты <> 100 Тогда
		ПредставлениеПроцентаВыплаты = 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = '%1% от причитающихся сумм'"),  
				ПроцентВыплаты);
	Иначе
		ПредставлениеПроцентаВыплаты = НСтр("ru = 'всеми причитающимися суммами'")
	КонецЕсли;
	
	Возврат ПредставлениеПроцентаВыплаты
	
КонецФункции

Функция ПредставлениеОкругления(Округление)
	
	Если ЗначениеЗаполнено(Округление) Тогда
		ПредставлениеОкругления = НРег(Округление);
	Иначе
		ПредставлениеОкругления = НСтр("ru = 'без округления'")
	КонецЕсли;
	
	Возврат ПредставлениеОкругления
	
КонецФункции

#КонецОбласти

#КонецОбласти
