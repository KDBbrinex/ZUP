#Область СлужебныйПрограммныйИнтерфейс

#Область Печать

// См. УправлениеПечатьюПереопределяемый.ПриОпределенииОбъектовСКомандамиПечати.
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Справочники.КомпетенцииПерсонала);
	
КонецПроцедуры

#КонецОбласти

#Область Свойства

// См. УправлениеСвойствамиПереопределяемый.ПриПолученииПредопределенныхНаборовСвойств.
Процедура ПриПолученииПредопределенныхНаборовСвойств(Наборы) Экспорт
	
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbfec-9802-11e9-80cd-4cedfb43b11a", Метаданные.Справочники.МероприятияОценкиПерсонала);
	
КонецПроцедуры

#КонецОбласти

// Дополняет список анкет респондента анкетами, назначенными физическому лицу, а не пользователю.
//
// Параметры:
//  ТаблицаАнкет - ТаблицаЗначений - см. Анкетирование.ТаблицаДоступныхРеспондентуАнкет.
//  Респондент	 - ОпределяемыйТип.Респондент - респондент, анкеты которого заполняются.
//
Процедура ДополнитьТаблицуДоступныхРеспондентуАнкет(ТаблицаАнкет, Респондент) Экспорт
	
	Если ТипЗнч(Респондент) <> Тип("СправочникСсылка.Пользователи") Тогда
		Возврат;
	КонецЕсли;
	
	АнкетыФизическогоЛица = Анкетирование.ТаблицаДоступныхРеспондентуАнкет(
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Респондент, "ФизическоеЛицо"));
		
	Если АнкетыФизическогоЛица = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Если ТаблицаАнкет = Неопределено Тогда
		ТаблицаАнкет = АнкетыФизическогоЛица;
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(АнкетыФизическогоЛица, ТаблицаАнкет);
	
КонецПроцедуры

// Предназначен для переопределения респондента-пользователя респондентом - физическим лицом.
//
// Параметры:
//  Форма	 - УправляемаяФорма - форма документа Анкета.
//
Процедура АнкетаПриСозданииНаСервере(Форма) Экспорт
	
	ТекущийПользователь = Пользователи.АвторизованныйПользователь();
	Если ТипЗнч(ТекущийПользователь) = Тип("СправочникСсылка.ВнешниеПользователи") 
		Или ТипЗнч(Форма.Объект.Респондент) <> Тип("СправочникСсылка.Пользователи") Тогда 
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоОпросОценки360(Форма.Объект.Опрос) Тогда
		Возврат;
	КонецЕсли;
	
	Форма.Объект.Респондент = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Форма.Объект.Респондент, "ФизическоеЛицо");
	
КонецПроцедуры

// Добавляет в список Обработчики процедуры-обработчики обновления,
// необходимые данной подсистеме.
//
// Параметры:
//	Обработчики - ТаблицаЗначений - см. описание функции НоваяТаблицаОбработчиковОбновления
//										общего модуля ОбновлениеИнформационнойБазы.
// 
Процедура ЗарегистрироватьОбработчикиОбновления(Обработчики) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


////////////////////////////////////////////////////////////////////////////////
// Служебный программный интерфейс.

// Возвращает структуру с демонстрационными текстами для шаблона анкеты нового мероприятия.
//
Функция ДемонстрационныеТексты(НаименованиеМероприятия) Экспорт
	
	ДемонстрационныеТексты = Новый Структура;
	
	// АПК:1223-выкл. Личные местоимения используются в текстах шаблонов 
	
	// Шаблон анкеты
	
	АнкетаЗаголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Анкета оценки персонала %1'"), НаименованиеМероприятия);
	
	АнкетаВступление =
	НСтр("ru = 'Вы приступаете к оценке сотрудника в рамках мероприятия по оценке персонала. Вам предстоит ответить на несколько вопросов об этом человеке.
          |
          |Чтобы оценка сотрудника была максимально объективной, важно, чтобы на вопросы отвечали именно Вы, без посторонней помощи.
          |
          |Если потребуется, заполнение анкеты можно прервать, пока редактирование анкеты не завершено, к ней можно перейти из списка доступных анкет.'");
	
	АнкетаЗаключение =
	НСтр("ru = 'Заполнение анкеты завершено. Если Вы ответили на все вопросы, можно завершить редактирование анкеты. 
          |Вернуться к заполнению анкеты будет невозможно.'");
	
	ДемонстрационныеТексты.Вставить("ШаблонАнкетыЗаголовок", АнкетаЗаголовок);
	ДемонстрационныеТексты.Вставить("ШаблонАнкетыВступление", АнкетаВступление);
	ДемонстрационныеТексты.Вставить("ШаблонАнкетыЗаключение", АнкетаЗаключение);
	
	// АПК:1223-вкл. 
	
	Возврат ДемонстрационныеТексты;
	
КонецФункции

// Возвращает структуру с демонстрационными текстами для шаблона сообщения нового мероприятия.
//
Функция ДемонстрационныеТекстыШаблоныСообщений() Экспорт
	
	ДемонстрационныеТексты = Новый Структура;
	
	// АПК:1223-выкл. Личные местоимения используются в текстах шаблонов 
	
	// Шаблон сообщений
	
	ТемаПисьма = НСтр("ru = 'Приглашение к участию в ""[МероприятияОценкиПерсонала.Наименование]""'");
	
	ТекстШаблонаПисьма = НСтр("ru = '<HTML><HEAD>
	|<META content=""text/html; charset=utf-8"" http-equiv=Content-Type>
	|<META name=GENERATOR content=""MSHTML 11.00.9600.18450""></HEAD>
	|<BODY>
	|<P>Уважаемый(ая) [ФизическиеЛица.ФИО]!</P>
	|<P>Вы являетесь участником мероприятия по оценке персонала ""[МероприятияОценкиПерсонала.Наименование]"".</P>
	|<P>Вам будет предложено ответить на ряд вопросов одной или нескольких анкет. Каждая анкета соответствует оценке характеристики одного сотрудника.</P>
	|<P>Участвовать в оценке можно по частям: до тех пор пока Вы не завершите редактирование анкеты, ее можно будет найти в списке доступных анкет и продолжить в другое удобное время.</P>
	|<P>Обращаем внимание на то, что плановая дата завершения мероприятия - [МероприятияОценкиПерсонала.ДатаНачала{ДЛФ=D}]<BR>После этого анкеты будут недоступны для заполнения.</P>
	|<P>Ответственным лицом за проведение данного мероприятие является [МероприятияОценкиПерсонала.Ответственный], ему Вы можете задать любые вопросы интересующие Вас вопросы.</P>
	|<P>Пожалуйста, чтобы приступить к работе, перейдите по этой ссылке. Либо Вы можете скопировать ее в адресную строку вашего браузера.<BR><a href =""[Произвольные.ВебСсылкаАнкетирования]"">[Произвольные.ВебСсылкаАнкетирования]</a></P>
	|<P>Заранее большое Вам спасибо за участие,<BR>команда проведения ""[МероприятияОценкиПерсонала.Наименование]""</P></BODY></HTML>'");
	
	ДемонстрационныеТексты.Вставить("Тема", ТемаПисьма);
	ДемонстрационныеТексты.Вставить("Текст", ТекстШаблонаПисьма);
	
	// АПК:1223-вкл. 
	
	Возврат ДемонстрационныеТексты;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Процедуры расчета оценок.

// Заполняет регистры сведений оценок персонала
// "ОценкиОтветовНаВопросыАнкет", "РезультатыОценкиВПроизвольнойФорме", "РезультатыОценкиРеспондентами", "РезультатыОценкиСотрудников"
// по содержимому ОтветыНаВопросыАнкет.
// передаваемые параметры
// 	Мероприятие - тип СправочникСсылка.МероприятияОценкиПерсонала - мероприятие, в рамках которого необходимо произвести пересчет
//  Анкета - тип ДокументСсылка.Анкета - анкета, в рамках ответов которой необходимо произвести пересчет
//	Удаление - тип булево - признак того, что произошла отмена проведения документа Анкеты.
Процедура РассчитатьОценкиПоОтветам(Мероприятие,Анкета,Удаление) Экспорт

	РассчитатьОценкиОтветовНаВопросыАнкет(Мероприятие,Анкета,Удаление);
	
	РассчитатьРезультатыОценкиСотрудников(Мероприятие);
	РассчитатьРезультатыОценкиРеспондентами(Мероприятие);
	
	СформироватьРезультатыОценкиПроизвольнойФормы(Мероприятие,Анкета);

КонецПроцедуры

Процедура РассчитатьОценкиОтветовНаВопросыАнкет(Мероприятие,Анкета,Удаление)
	
	НаборЗаписей = РегистрыСведений.ОценкиОтветовНаВопросыАнкет.СоздатьНаборЗаписей();
	
	Если НЕ Удаление Тогда
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	МероприятияОценкиПерсоналаВопросы.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
		|	МероприятияОценкиПерсоналаВопросы.Вопрос КАК Вопрос
		|ПОМЕСТИТЬ ВТВопросыХарактеристик
		|ИЗ
		|	Справочник.МероприятияОценкиПерсонала.ВопросыХарактеристик КАК МероприятияОценкиПерсоналаВопросы
		|ГДЕ
		|	МероприятияОценкиПерсоналаВопросы.Ссылка = &Мероприятие
		|	И МероприятияОценкиПерсоналаВопросы.ХарактеристикаПерсонала <> ЗНАЧЕНИЕ(ПланВидовХарактеристик.ХарактеристикиПерсонала.ПустаяСсылка)
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Вопрос
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	&мероприятие КАК Мероприятие,
		|	МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо КАК ФизическоеЛицо,
		|	Анкеты.Респондент КАК Респондент,
		|	МероприятияОценкиПерсоналаРеспонденты.РольРеспондента КАК РольРеспондента,
		|	ВТВопросыХарактеристик.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
		|	ОтветыНаВопросыАнкет.ЭлементарныйВопрос КАК Вопрос,
		|	ВариантыОтветовАнкет.Ссылка КАК Ответ,
		|	ВариантыОтветовАнкет.РеквизитДопУпорядочивания КАК ОбщаяОценка
		|ПОМЕСТИТЬ ВТОтветы
		|ИЗ
		|	РегистрСведений.ОтветыНаВопросыАнкет КАК ОтветыНаВопросыАнкет
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.Анкета КАК Анкеты
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.МероприятияОценкиПерсонала.Респонденты КАК МероприятияОценкиПерсоналаРеспонденты
		|			ПО (МероприятияОценкиПерсоналаРеспонденты.Ссылка = &Мероприятие)
		|				И Анкеты.Респондент = МероприятияОценкиПерсоналаРеспонденты.Респондент
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.МероприятияОценкиПерсонала.Участники КАК МероприятияОценкиПерсоналаУчастники
		|			ПО Анкеты.Опрос = МероприятияОценкиПерсоналаУчастники.НазначениеОпроса
		|				И (МероприятияОценкиПерсоналаУчастники.Ссылка = &Мероприятие)
		|				И (&УсловиеПоФизическомуЛицу)
		|		ПО (Анкеты.Ссылка = &Анкета)
		|			И ОтветыНаВопросыАнкет.Анкета = Анкеты.Ссылка
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВариантыОтветовАнкет КАК ВариантыОтветовАнкет
		|		ПО ОтветыНаВопросыАнкет.ЭлементарныйВопрос = ВариантыОтветовАнкет.Владелец
		|			И ОтветыНаВопросыАнкет.Ответ = ВариантыОтветовАнкет.Ссылка
		|			И (НЕ ВариантыОтветовАнкет.ПометкаУдаления)
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТВопросыХарактеристик КАК ВТВопросыХарактеристик
		|		ПО ОтветыНаВопросыАнкет.ЭлементарныйВопрос = ВТВопросыХарактеристик.Вопрос
		|
		|СГРУППИРОВАТЬ ПО
		|	Анкеты.Респондент,
		|	ОтветыНаВопросыАнкет.ЭлементарныйВопрос,
		|	ВариантыОтветовАнкет.РеквизитДопУпорядочивания,
		|	МероприятияОценкиПерсоналаРеспонденты.РольРеспондента,
		|	МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо,
		|	ВариантыОтветовАнкет.Ссылка,
		|	ВТВопросыХарактеристик.ХарактеристикаПерсонала
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Вопрос,
		|	Ответ,
		|	ХарактеристикаПерсонала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТОтветы.Мероприятие КАК Мероприятие,
		|	ВТОтветы.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ВТОтветы.Респондент КАК Респондент,
		|	ВТОтветы.РольРеспондента КАК РольРеспондента,
		|	ВТОтветы.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
		|	ВТОтветы.Вопрос КАК Вопрос,
		|	ВТОтветы.Ответ КАК Ответ,
		|	ЕСТЬNULL(ОценкиВариантовОтвета.ОценкаОтвета, ВТОтветы.ОбщаяОценка) КАК Оценка
		|ИЗ
		|	ВТОтветы КАК ВТОтветы
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОценкиВариантовОтвета КАК ОценкиВариантовОтвета
		|		ПО ВТОтветы.Вопрос = ОценкиВариантовОтвета.Вопрос
		|			И ВТОтветы.Ответ = ОценкиВариантовОтвета.ВариантОтвета
		|			И ВТОтветы.ХарактеристикаПерсонала = ОценкиВариантовОтвета.ХарактеристикаПерсонала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТВопросыХарактеристик
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|УНИЧТОЖИТЬ ВТОтветы");
		Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
		Запрос.УстановитьПараметр("Анкета", Анкета);
		Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Мероприятие, "СпособЗаполненияРеспондентов") = ПредопределенноеЗначение("Перечисление.СпособЗаполненияРеспондентовВОценке360.ЕдиноеДляВсех") Тогда
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.МероприятияОценкиПерсонала.Респонденты", "Справочник.МероприятияОценкиПерсонала.РеспондентыЕдиныйНабор");
			Запрос.УстановитьПараметр("УсловиеПоФизическомуЛицу", Истина);
		Иначе
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловиеПоФизическомуЛицу", "(МероприятияОценкиПерсоналаРеспонденты.ФизическоеЛицо = МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо)");
		КонецЕсли;
		
		РезультатЗапроса = Запрос.Выполнить().Выгрузить();
		
		НаборЗаписей.Загрузить(РезультатЗапроса);
	Иначе
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	&мероприятие КАК Мероприятие,
		|	МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо КАК ФизическоеЛицо,
		|	Анкеты.Респондент КАК Респондент
		|ИЗ
		|	Документ.Анкета КАК Анкеты
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.НазначениеОпросов КАК НазначениеОпросов
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.МероприятияОценкиПерсонала.Участники КАК МероприятияОценкиПерсоналаУчастники
		|			ПО НазначениеОпросов.Ссылка = МероприятияОценкиПерсоналаУчастники.НазначениеОпроса
		|				И (МероприятияОценкиПерсоналаУчастники.Ссылка = &Мероприятие)
		|		ПО Анкеты.Опрос = НазначениеОпросов.Ссылка
		|			И (Анкеты.Ссылка = &Анкета)
		|
		|СГРУППИРОВАТЬ ПО
		|	Анкеты.Респондент,
		|	МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо");
		Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
		Запрос.УстановитьПараметр("Анкета", Анкета);
		РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	КонецЕсли;
	
	Если РезультатЗапроса.Количество()>0 Тогда
		НаборЗаписей.Отбор.Мероприятие.Установить(РезультатЗапроса[0].Мероприятие);
		НаборЗаписей.Отбор.ФизическоеЛицо.Установить(РезультатЗапроса[0].ФизическоеЛицо);
		НаборЗаписей.Отбор.Респондент.Установить(РезультатЗапроса[0].Респондент);
		НаборЗаписей.Записать();
	Иначе
		ПредставлениеОшибки =
			НСтр("ru = 'Не удалось рассчитать оценки ответов на вопросы анкет'");
		ВызватьИсключение ПредставлениеОшибки;
	КонецЕсли;
	
КонецПроцедуры

Процедура РассчитатьРезультатыОценкиСотрудников(Мероприятие)
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ОценкиОтветов.Мероприятие КАК Мероприятие,
	|	ОценкиОтветов.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОценкиОтветов.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
	|	СРЕДНЕЕ(ОценкиОтветов.Оценка) КАК Оценка,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ОценкиОтветов.Респондент) КАК КоличествоРеспондентов
	|ПОМЕСТИТЬ ОценкиСотрудников
	|ИЗ
	|	РегистрСведений.ОценкиОтветовНаВопросыАнкет КАК ОценкиОтветов
	|ГДЕ
	|	ОценкиОтветов.Мероприятие = &Мероприятие
	|
	|СГРУППИРОВАТЬ ПО
	|	ОценкиОтветов.Мероприятие,
	|	ОценкиОтветов.ФизическоеЛицо,
	|	ОценкиОтветов.ХарактеристикаПерсонала
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОценкиСотрудников.Мероприятие КАК Мероприятие,
	|	ОценкиСотрудников.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОценкиСотрудников.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
	|	ОценкиСотрудников.Оценка КАК Оценка,
	|	ОценкиСотрудников.КоличествоРеспондентов КАК КоличествоРеспондентов,
	|	СУММА(ВЫБОР
	|			КОГДА ОценкиДляСравнения.Оценка < ОценкиСотрудников.Оценка
	|				ТОГДА 1
	|			КОГДА ОценкиДляСравнения.Оценка = ОценкиСотрудников.Оценка
	|				ТОГДА 0.5
	|			ИНАЧЕ 0
	|		КОНЕЦ) / СтатистикаОценок.КоличествоОценок * 100 КАК Рейтинг
	|ИЗ
	|	ОценкиСотрудников КАК ОценкиСотрудников
	|		ЛЕВОЕ СОЕДИНЕНИЕ ОценкиСотрудников КАК ОценкиДляСравнения
	|		ПО ОценкиСотрудников.Мероприятие = ОценкиДляСравнения.Мероприятие
	|			И ОценкиСотрудников.ХарактеристикаПерсонала = ОценкиДляСравнения.ХарактеристикаПерсонала
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			ОценкиСотрудников.ХарактеристикаПерсонала КАК ХарактеристикаПерсонала,
	|			КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ОценкиСотрудников.ФизическоеЛицо) КАК КоличествоОценок
	|		ИЗ
	|			ОценкиСотрудников КАК ОценкиСотрудников
	|		
	|		СГРУППИРОВАТЬ ПО
	|			ОценкиСотрудников.ХарактеристикаПерсонала) КАК СтатистикаОценок
	|		ПО ОценкиСотрудников.ХарактеристикаПерсонала = СтатистикаОценок.ХарактеристикаПерсонала
	|
	|СГРУППИРОВАТЬ ПО
	|	ОценкиСотрудников.Мероприятие,
	|	ОценкиСотрудников.ФизическоеЛицо,
	|	ОценкиСотрудников.ХарактеристикаПерсонала,
	|	ОценкиСотрудников.Оценка,
	|	ОценкиСотрудников.КоличествоРеспондентов,
	|	СтатистикаОценок.КоличествоОценок");
	
	Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
	
	НаборЗаписей = РегистрыСведений.РезультатыОценкиСотрудников.СоздатьНаборЗаписей();
	НаборЗаписей.Загрузить(Запрос.Выполнить().Выгрузить());
	
	НаборЗаписей.Отбор.Мероприятие.Установить(Мероприятие);
	НаборЗаписей.Записать();
	
КонецПроцедуры

Процедура РассчитатьРезультатыОценкиРеспондентами(Мероприятие, ДиапазонСогласованности = 0.5)
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ОценкиОтветов.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОценкиОтветов.Мероприятие КАК Мероприятие,
	|	ОценкиОтветов.Респондент КАК Респондент,
	|	СРЕДНЕЕ(ОценкиОтветов.Оценка) КАК Оценка
	|ПОМЕСТИТЬ ОценкиРеспондентами
	|ИЗ
	|	РегистрСведений.ОценкиОтветовНаВопросыАнкет КАК ОценкиОтветов
	|ГДЕ
	|	ОценкиОтветов.Мероприятие = &Мероприятие
	|
	|СГРУППИРОВАТЬ ПО
	|	ОценкиОтветов.Мероприятие,
	|	ОценкиОтветов.ФизическоеЛицо,
	|	ОценкиОтветов.Респондент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОценкиРеспондентами.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОценкиРеспондентами.Мероприятие КАК Мероприятие,
	|	ОценкиРеспондентами.Респондент КАК Респондент,
	|	ОценкиРеспондентами.Оценка КАК Оценка,
	|	СУММА(ВЫБОР
	|			КОГДА ОценкиРеспондентами.Оценка = ОценкиДляСравнения.Оценка
	|				ТОГДА 0.5
	|			КОГДА ОценкиРеспондентами.Оценка < ОценкиДляСравнения.Оценка
	|				ТОГДА 1
	|			ИНАЧЕ 0
	|		КОНЕЦ) / СтатистикаОценок.КоличествоОценок * 100 КАК Критичность,
	|	СУММА(ВЫБОР
	|			КОГДА ОценкиРеспондентами.Оценка < ОценкиДляСравнения.Оценка + &ДиапазонСогласованности / 2
	|					И ОценкиРеспондентами.Оценка > ОценкиДляСравнения.Оценка - &ДиапазонСогласованности / 2
	|				ТОГДА 1
	|			КОГДА ОценкиРеспондентами.Оценка = ОценкиДляСравнения.Оценка + &ДиапазонСогласованности / 2
	|					ИЛИ ОценкиРеспондентами.Оценка = ОценкиДляСравнения.Оценка - &ДиапазонСогласованности / 2
	|				ТОГДА 0.5
	|			ИНАЧЕ 0
	|		КОНЕЦ) / СтатистикаОценок.КоличествоОценок * 100 КАК Согласованность
	|ИЗ
	|	ОценкиРеспондентами КАК ОценкиРеспондентами
	|		ЛЕВОЕ СОЕДИНЕНИЕ ОценкиРеспондентами КАК ОценкиДляСравнения
	|		ПО ОценкиРеспондентами.Мероприятие = ОценкиДляСравнения.Мероприятие
	|			И ОценкиРеспондентами.ФизическоеЛицо = ОценкиДляСравнения.ФизическоеЛицо
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			ОценкиРеспондентами.ФизическоеЛицо КАК ФизическоеЛицо,
	|			КОЛИЧЕСТВО(ОценкиРеспондентами.Оценка) КАК КоличествоОценок
	|		ИЗ
	|			ОценкиРеспондентами КАК ОценкиРеспондентами
	|		
	|		СГРУППИРОВАТЬ ПО
	|			ОценкиРеспондентами.ФизическоеЛицо) КАК СтатистикаОценок
	|		ПО ОценкиРеспондентами.ФизическоеЛицо = СтатистикаОценок.ФизическоеЛицо
	|
	|СГРУППИРОВАТЬ ПО
	|	ОценкиРеспондентами.ФизическоеЛицо,
	|	ОценкиРеспондентами.Мероприятие,
	|	ОценкиРеспондентами.Респондент,
	|	ОценкиРеспондентами.Оценка,
	|	СтатистикаОценок.КоличествоОценок");
	
	Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
	Запрос.УстановитьПараметр("ДиапазонСогласованности", ДиапазонСогласованности);
	
	НаборЗаписей = РегистрыСведений.РезультатыОценкиРеспондентами.СоздатьНаборЗаписей();
	НаборЗаписей.Загрузить(Запрос.Выполнить().Выгрузить());
	
	НаборЗаписей.Отбор.Мероприятие.Установить(Мероприятие);
	НаборЗаписей.Записать();
	
КонецПроцедуры

Процедура СформироватьРезультатыОценкиПроизвольнойФормы(Мероприятие,Анкета)
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	МероприятияОценкиПерсоналаУчастники.ФизическоеЛицо КАК ФизическоеЛицо
	|ПОМЕСТИТЬ ВТФизическиеЛица
	|ИЗ
	|	Документ.Анкета КАК Анкета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.МероприятияОценкиПерсонала.Участники КАК МероприятияОценкиПерсоналаУчастники
	|		ПО Анкета.Опрос = МероприятияОценкиПерсоналаУчастники.НазначениеОпроса
	|			И (Анкета.Ссылка = &Анкета)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ФизическоеЛицо
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&Мероприятие КАК Мероприятие,
	|	УчастникиМероприятия.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ОтветыНаВопросыАнкет.ЭлементарныйВопрос КАК Вопрос,
	|	ОтветыНаВопросыАнкет.Ответ
	|ИЗ
	|	РегистрСведений.ОтветыНаВопросыАнкет КАК ОтветыНаВопросыАнкет
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.Анкета КАК Анкеты
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.МероприятияОценкиПерсонала.Участники КАК УчастникиМероприятия
	|				ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТФизическиеЛица КАК ВТФизическиеЛица
	|				ПО УчастникиМероприятия.ФизическоеЛицо = ВТФизическиеЛица.ФизическоеЛицо
	|			ПО (УчастникиМероприятия.Ссылка = &Мероприятие)
	|				И Анкеты.Опрос = УчастникиМероприятия.НазначениеОпроса
	|		ПО ОтветыНаВопросыАнкет.Анкета = Анкеты.Ссылка
	|			И (ОтветыНаВопросыАнкет.ЭлементарныйВопрос.ТипОтвета = ЗНАЧЕНИЕ(Перечисление.ТипыОтветовНаВопрос.Строка))
	|ИТОГИ ПО
	|	ФизическоеЛицо КАК ФизическоеЛицо,
	|	Вопрос КАК Вопрос
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ВТФизическиеЛица");
	
	Запрос.УстановитьПараметр("Мероприятие", Мероприятие);
	Запрос.УстановитьПараметр("Анкета", Анкета);
	
	НаборЗаписей = РегистрыСведений.РезультатыОценкиВПроизвольнойФорме.СоздатьНаборЗаписей();
	
	ВыборкаПоОцениваемым = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаПоОцениваемым.Следующий() Цикл
		НаборЗаписей.Отбор.ФизическоеЛицо.Установить(ВыборкаПоОцениваемым.ФизическоеЛицо);
		ВыборкаПоВопросам = ВыборкаПоОцениваемым.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаПоВопросам.Следующий() Цикл
			Оценка = "";
			Выборка = ВыборкаПоВопросам.Выбрать();
			Пока Выборка.Следующий() Цикл
				Оценка = Оценка + ?(НЕ ПустаяСтрока(Оценка), Символы.ПС, "") + Выборка.Ответ;
			КонецЦикла;
			СтрокаНабора = НаборЗаписей.Добавить();
			СтрокаНабора.Мероприятие	= Мероприятие;
			СтрокаНабора.ФизическоеЛицо		= ВыборкаПоОцениваемым.ФизическоеЛицо;
			СтрокаНабора.Вопрос			= ВыборкаПоВопросам.Вопрос;
			СтрокаНабора.Оценка			= Оценка;
		КонецЦикла;
	КонецЦикла;
	
	НаборЗаписей.Отбор.Мероприятие.Установить(Мероприятие);
	НаборЗаписей.Записать();
	
КонецПроцедуры

#Область ПеренесенныйШаблоныСообщенийСервер 

// Параметр - готовая навигационная ссылка.
Функция ВнешняяСсылкаНаОбъект(Параметр, ПользовательИБ, Пароль = Неопределено)
	
	УстановитьПривилегированныйРежим(Истина);
	НайденныйПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ПользовательИБ.ИдентификаторПользователяИБ);
	
	СтрокаПользователя = ?(НайденныйПользовательИБ = Неопределено, "", "?N="+НайденныйПользовательИБ.Имя);
	СтрокаПароля = ?(Пароль = Неопределено, "", "&P="+Пароль);
	
	ИтоговаяСтрока = ОбщегоНазначения.АдресПубликацииИнформационнойБазыВИнтернете() + СтрокаПользователя + СтрокаПароля +"#" +  Параметр;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат ИтоговаяСтрока;
	
КонецФункции
	
#КонецОбласти 

#Область НастройкиВариантовОтчетов

// Определяет разделы, в которых доступна панель отчетов.
//
// Параметры:
//   Разделы (Массив) из (ОбъектМетаданных).
//
// Описание:
//   В Разделы необходимо добавить метаданные тех разделов,
//   в которых размещены команды вызова панелей отчетов.
//
// Например:
//	Разделы.Добавить(Метаданные.Подсистемы.ИмяПодсистемы);
//
Процедура ОпределитьРазделыСВариантамиОтчетов(Разделы) Экспорт
	
	Если Разделы.НайтиПоЗначению(Метаданные.Подсистемы.ОбучениеИРазвитие) = Неопределено Тогда
		Разделы.Добавить(Метаданные.Подсистемы.ОбучениеИРазвитие, НСтр("ru = 'Отчеты по обучению и развитию'"));
	КонецЕсли;
	
КонецПроцедуры

// Содержит настройки размещения вариантов отчетов в панели отчетов.
// Описание см. ЗарплатаКадрыВариантыОтчетов.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчетов(Настройки) Экспорт
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.ОценкаПерсонала);
	
	Вариант = ВариантыОтчетов.ОписаниеВарианта(Настройки, Метаданные.Отчеты.ОценкаПерсонала, "Корпоративный");
	Вариант.ФункциональныеОпции.Добавить("ИспользоватьОценкуПерсонала");
	
	Вариант = ВариантыОтчетов.ОписаниеВарианта(Настройки, Метаданные.Отчеты.ОценкаПерсонала, "Индивидуальный");
	Вариант.ФункциональныеОпции.Добавить("ИспользоватьОценкуПерсонала");
	
КонецПроцедуры

#КонецОбласти

// Функция дополняет описание профиля ролями для работы с подсистемой Оценка персонала.
// 
Процедура ДополнитьОписаниеПрофиляОценкойПерсонала(ОписаниеПрофиля) Экспорт
	
	// Роли оценки персонала.
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "УправлениеМероприятиемОценкиПерсонала");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеШаблоновАнкет");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеРезультатовОценкиПерсонала");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеШаблоновАнкет");
	
	// Роли на общие объекты КОРП из подсистемы «характеристики персонала».
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеДействийСотрудников");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеХарактеристикПерсонала");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеКомпетенцийПерсонала");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "УправлениеМероприятиемОценкиПерсонала");
	
	// Анкетирование.
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеОпросов", "СтандартныеПодсистемы.Анкетирование");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеШаблоновАнкет", "СтандартныеПодсистемы.Анкетирование");
	
	// Интерфейсные роли.
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ПодсистемаОценкаПерсонала");
	
	// Добавление сопутствующих ролей.
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ДобавлениеИзменениеДанныхФизическихЛицЗарплатаКадры"); // для работы с почтой физических лиц
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "БазовыеПраваКонфигурацииЗарплатаКадрыРасширенная");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеАрхиваФизическихЛиц");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеДолжностей");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеПодразделенийОрганизации");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеДанныхФизическихЛицЗарплатаКадрыРасширенная");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеДанныхСотрудников");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеДанныхСотрудниковРасширенная");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеИспытательногоСрокаСотрудников");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "НастройкаГруппСотрудников");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеДанныхФизическихЛицЗарплатаКадры");
	ЗарплатаКадрыРасширенный.ДобавитьВОписаниеПрофиляРоль(ОписаниеПрофиля, "ЧтениеКадровогоСостоянияРасширенная");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ПоискФизическихЛиц") Тогда
		МодульПоискФизическихЛиц = ОбщегоНазначения.ОбщийМодуль("ПоискФизическихЛиц");
		МодульПоискФизическихЛиц.ДополнитьОписаниеПрофиля(ОписаниеПрофиля);
	КонецЕсли;
	
КонецПроцедуры

#Область НачальнаяНастройкаПрограммы

Процедура ЗначенияСохраняемыхРеквизитовФормыНачальнаяНастройкаПрограммы(Форма, СохраняемыеРеквизиты) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Форма.РаботаВКОРП Тогда
		Возврат;
	КонецЕсли;
	
	СохраняемыеРеквизиты.Вставить("НастройкиОценкиПерсонала", ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(
			Форма.НастройкиОценкиПерсонала, Метаданные.РегистрыСведений.НастройкиОценкиПерсонала));
	
КонецПроцедуры

Процедура СохраненныеНастройкиВРеквизитыФормыНачальнаяНастройкаПрограммы(Форма, СохраненныеНастройки) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда
		Возврат;
	КонецЕсли;
	
	Если СохраненныеНастройки.Свойство("НастройкиОценкиПерсонала") Тогда
		ЗаполнитьЗначенияСвойств(Форма["НастройкиОценкиПерсонала"], СохраненныеНастройки["НастройкиОценкиПерсонала"]);
	КонецЕсли;
	
КонецПроцедуры

Процедура НастройкиПрограммыВРеквизитыФормы(Форма) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда
		Возврат;
	КонецЕсли;
	
	Настройки = РегистрыСведений.НастройкиОценкиПерсонала.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	НастройкиСтруктура = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(Настройки, Метаданные.РегистрыСведений.НастройкиОценкиПерсонала);
	ЗаполнитьЗначенияСвойств(Форма.НастройкиОценкиПерсонала, НастройкиСтруктура);
	
КонецПроцедуры

Процедура ПолучитьНастройкиПрограммы(НастройкиПрограммы) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда
		Возврат;
	КонецЕсли;
	
	Настройки = РегистрыСведений.НастройкиОценкиПерсонала.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	НастройкиСтруктура = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(Настройки, Метаданные.РегистрыСведений.НастройкиОценкиПерсонала);
	НастройкиПрограммы.Вставить("НастройкиОценкиПерсонала", НастройкиСтруктура);
	
КонецПроцедуры

Процедура ЗаписатьНастройкиНачальнаяНастройкаПрограммы(Параметры) Экспорт

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда
		Возврат;
	КонецЕсли;
	
	Настройки = РегистрыСведений.НастройкиОценкиПерсонала.СоздатьМенеджерЗаписи();
	ЗаполнитьЗначенияСвойств(Настройки, Параметры.НастройкиОценкиПерсонала);
	Настройки.Записать();
	
КонецПроцедуры

#КонецОбласти

// Возвращает массив с набором вариантов ответов на вопросы анкетирования при проведении мероприятий оценки персонала.
//
Функция ВариантыОтветовНаВопросыАнкетированияДляОценкиПерсонала() Экспорт
	
	ВариантыОтветов = Новый Массив;
	
	ВариантыОтветов.Добавить(НСтр("ru = 'Всегда'"));
	ВариантыОтветов.Добавить(НСтр("ru = 'Часто'"));
	ВариантыОтветов.Добавить(НСтр("ru = 'Редко'"));
	ВариантыОтветов.Добавить(НСтр("ru = 'Иногда'"));
	ВариантыОтветов.Добавить(НСтр("ru = 'Никогда'"));
	
	Возврат ВариантыОтветов;
	
КонецФункции

Процедура ЗаполнитьПараметрМероприятияОценкиШаблонаСообщения(ПараметрыСообщения, Объект) Экспорт

	ПараметрыСообщения.Вставить("Наименование", Объект.Наименование);
	ПараметрыСообщения.Вставить("ДатаНачала", Формат(Объект.ДатаНачала, "ДЛФ=D"));
	ПараметрыСообщения.Вставить("ДатаОкончания", Формат(Объект.ДатаОкончания, "ДЛФ=D"));
	ПараметрыСообщения.Вставить("Ответственный", Объект.Ответственный);

КонецПроцедуры

#Область РаботаСШаблонамиСообщений

Процедура ПриПодготовкеШаблонаСообщения(РеквизитыОбъектаНазначения, Вложения, НазначениеШаблона, ДополнительныеПараметры) Экспорт

	Если Не ДополнительныеПараметры.Свойство("ВладелецШаблона") Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДополнительныеПараметры.ВладелецШаблона) <> Тип("СправочникСсылка.МероприятияОценкиПерсонала") Тогда
		Возврат;
	КонецЕсли;

	ДополнитьШаблонРеквизитамиМероприятияОценкиПерсонала(РеквизитыОбъектаНазначения, Вложения, ДополнительныеПараметры);
	ДополнитьШаблонПроизвольнымиПараметрами(РеквизитыОбъектаНазначения, Вложения, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ПриФормированииСообщения(Сообщение, НазначениеШаблона, ПредметСообщения, ДополнительныеПараметры) Экспорт

	Если Не ДополнительныеПараметры.Свойство("ВладелецШаблона") Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДополнительныеПараметры.ВладелецШаблона) <> Тип("СправочникСсылка.МероприятияОценкиПерсонала") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьРеквизитыШаблонаЗначениямиМероприятияОценки(Сообщение, ПредметСообщения, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ПриЗаполненииПочтыПолучателейВСообщении(ПолучателиПисьма, НазначениеШаблона, ПредметСообщения) Экспорт
	
	Если Не ПредметСообщения.Свойство("ПараметрыПолучателей") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыПолучателей = ПредметСообщения.ПараметрыПолучателей;
	Если ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(ПараметрыПолучателей, "ПереопределятьПолучателей", Ложь) Тогда
		ПереопределитьПолучателейПисьма(ПолучателиПисьма, НазначениеШаблона, ПараметрыПолучателей);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДополнитьШаблонРеквизитамиМероприятияОценкиПерсонала(РеквизитыОбъектаНазначения, Вложения, ДополнительныеПараметры)

	// Этап работы.
	РеквизитыШаблона = РеквизитыОбъектаНазначения.Родитель.Владелец().Строки;
	
	ГруппаМероприятиеОценки = РеквизитыШаблона.Добавить();
	ГруппаМероприятиеОценки.Имя = "МероприятияОценкиПерсонала";
	ГруппаМероприятиеОценки.Представление = НСтр("ru = 'Мероприятие оценки персонала'");
	
	РеквизитыМероприятия = ГруппаМероприятиеОценки.Строки;
	
	// Наименование.
	НоваяСтрока = РеквизитыМероприятия.Добавить();
	НоваяСтрока.Имя = "МероприятияОценкиПерсонала.Наименование";
	НоваяСтрока.Представление = НСтр("ru = 'Наименование'");
	
	// Дата начала.
	НоваяСтрока = РеквизитыМероприятия.Добавить();
	НоваяСтрока.Имя = "МероприятияОценкиПерсонала.ДатаНачала";
	НоваяСтрока.Представление = НСтр("ru = 'Дата начала'");
	
	// Дата окончания.
	НоваяСтрока = РеквизитыМероприятия.Добавить();
	НоваяСтрока.Имя = "МероприятияОценкиПерсонала.ДатаОкончания";
	НоваяСтрока.Представление = НСтр("ru = 'Дата окончания'");
	
	// Дата Ответственный.
	НоваяСтрока = РеквизитыМероприятия.Добавить();
	НоваяСтрока.Имя = "МероприятияОценкиПерсонала.Ответственный";
	НоваяСтрока.Представление = НСтр("ru = 'Ответственный'");

КонецПроцедуры

Процедура ДополнитьШаблонПроизвольнымиПараметрами(РеквизитыОбъектаНазначения, Вложения, ДополнительныеПараметры)

	Описание = Новый Структура("ОписаниеТипа, Представление");
	Описание.ОписаниеТипа = Новый ОписаниеТипов("Строка");
	Описание.Представление = НСтр("ru = 'WEB ссылка на форму анкетирования'");
	
	ДополнительныеПараметры.Параметры.Вставить("ВебСсылкаАнкетирования", Описание);

КонецПроцедуры

Процедура ЗаполнитьРеквизитыШаблонаЗначениямиМероприятияОценки(Сообщение, ПредметСообщения, ДополнительныеПараметры)

	ПараметрыШаблона = Сообщение.ДополнительныеПараметры.ПроизвольныеПараметры;
	Если ПараметрыШаблона["МероприятияОценкиПерсонала"] = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыМероприятияОценкиПерсонала = ПараметрыШаблона["МероприятияОценкиПерсонала"];
	ПараметрыСообщения = ДополнительныеПараметры.ПараметрыСообщения;
	
	Для каждого ПараметрСообщения Из ПараметрыСообщения Цикл
		ПараметрыМероприятияОценкиПерсонала.Вставить(ПараметрСообщения.Ключ, ПараметрСообщения.Значение);
	КонецЦикла; 

КонецПроцедуры

Процедура ПереопределитьПолучателейПисьма(ПолучателиПисьма, НазначениеШаблона, ПараметрыПолучателей)

	ПолучателиПисьма.Очистить();
	
	НоваяСтрока = ПолучателиПисьма.Добавить();
	НоваяСтрока.Представление = ПараметрыПолучателей.ФИОПолучателя;
	НоваяСтрока.Контакт = ПараметрыПолучателей.ФИОПолучателя;
	НоваяСтрока.Адрес = ПараметрыПолучателей.Адрес;

КонецПроцедуры

Процедура ЗаполнитьРеквизитШаблонаВебСсылкаАнкетирования(ПараметрыШаблона) Экспорт

	Если НЕ ПараметрыШаблона.Свойство("ПроизвольныеПараметры") Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ПараметрыШаблона.Свойство("АдресВебСсылкиДоступныеАнкеты") ИЛИ НЕ ПараметрыШаблона.Свойство("ПользовательИБ") Тогда
		Возврат;
	КонецЕсли;
	
	ВебСсылкаАнкетирования = ВнешняяСсылкаНаОбъект(
		ПараметрыШаблона.АдресВебСсылкиДоступныеАнкеты,
		ПараметрыШаблона.ПользовательИБ);
		
	ПараметрыШаблона["ПроизвольныеПараметры"].Вставить("ВебСсылкаАнкетирования", ВебСсылкаАнкетирования);
	
КонецПроцедуры

Процедура ДобавитьПереопределениеПолучателейСообщения(ПараметрыШаблона, ПриглашаемыйРеспондент) Экспорт

	ПараметрыПолучателей = Новый Структура;
	
	ФИОПолучателя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПриглашаемыйРеспондент.ФизическоеЛицо, "ФИО");
	ПараметрыПолучателей.Вставить("ПереопределятьПолучателей", Истина);
	ПараметрыПолучателей.Вставить("Получатель", ПриглашаемыйРеспондент.ФизическоеЛицо);
	ПараметрыПолучателей.Вставить("ФИОПолучателя", ФИОПолучателя);
	ПараметрыПолучателей.Вставить("Адрес", ПриглашаемыйРеспондент.Адрес);
	
	ПараметрыШаблона.Вставить("ПараметрыПолучателей", ПараметрыПолучателей);

КонецПроцедуры

#КонецОбласти 

Функция ЭтоОпросОценки360(Опрос)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Опрос", Опрос);
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА КАК Поле1
	|ИЗ
	|	Справочник.МероприятияОценкиПерсонала.Участники КАК МероприятияОценкиПерсоналаУчастники
	|ГДЕ
	|	МероприятияОценкиПерсоналаУчастники.НазначениеОпроса = &Опрос";
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат Не Запрос.Выполнить().Пустой();

КонецФункции

#КонецОбласти 