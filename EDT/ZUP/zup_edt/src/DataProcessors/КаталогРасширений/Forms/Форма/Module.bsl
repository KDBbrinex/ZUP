
#Область ОписаниеПеременных

&НаКлиенте
Перем ИдентификаторыПоследнихРасширений;

&НаКлиенте
Перем СоответствиеТиповРазделам;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Расширения.Шапка = Ложь;
	
	АдресХранилищаРезультат = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
		
	КартинкаДлительная85 = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.КаталогРасширенийДлительнаяОперация85, УникальныйИдентификатор);
	КартинкаДлительная256 = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.КаталогРасширенийДлительнаяОперация256, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаУстановкаСоединения;
	
	ИдентификаторыПоследнихРасширений = Новый Соответствие;
	СоответствиеТиповРазделам = Новый Соответствие;
	
	НачатьПодключениеКМенеджеруСервиса();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия <> "КаталогРасширений_ИзменениеСостояния" Тогда
		Возврат;
	КонецЕсли;
	
	СтрокиРасширения = Расширения.НайтиСтроки(Новый Структура("ИдентификаторРасширения", Параметр.ИдентификаторРасширения));
	
	Если СтрокиРасширения.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	СтрокиРасширения[0].Состояние = СостояниеРасширения(Параметр.Состояние);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтрокаПоискаОчистка(Элемент, СтандартнаяОбработка)
	НачатьОбновлениеСпискаРасширений();
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	ОбновитьСписокРасширений(Ложь, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ТолькоУстановленныеПриИзменении(Элемент)
	
	ОбновитьСписокРасширений(Ложь, ЗначениеЗаполнено(СтрокаПоиска));
	ПоказатьОповещениеОЗагрузкеДанных(НСтр("ru = 'Обработка списка расширений'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ВариантСпискаПриИзменении(Элемент)
	
	ИзменитьРаздел();
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбновитьСписокРасширений(Ложь, Истина, Текст);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРасширения

&НаКлиенте
Процедура РасширенияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеСтроки = Расширения.НайтиПоИдентификатору(ВыбраннаяСтрока);
	
	Если Поле = Элементы.РасширенияПоказатьСледующиеРасширения И НЕ ПустаяСтрока(ДанныеСтроки.ПоказатьСледующиеРасширения) Тогда
		ЗагрузитьЕще(Неопределено);
		Возврат;	
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ДанныеСтроки.ПоказатьСледующиеРасширения) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыНовойФормы = Новый Структура;
	ПараметрыНовойФормы.Вставить("ИдентификаторВерсии", ДанныеСтроки.ИдентификаторВерсии);
	ПараметрыНовойФормы.Вставить("НаименованиеРасширения", ДанныеСтроки.НаименованиеРасширения);
	
	ОткрытьФорму("Обработка.КаталогРасширений.Форма.ФормаОбъектаРасширение", ПараметрыНовойФормы, ЭтотОбъект,,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Обновить(Команда)
	
	НачатьОбновлениеСпискаРасширений();
		
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьЕще(Команда)
		
	ОбновитьСписокРасширений(Истина);
	ПоказатьОповещениеОЗагрузкеДанных(НСтр("ru = 'Обработка списка расширений'"));
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиРасширения(Команда)
	
	ОбновитьСписокРасширений(Ложь, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура НачатьОбновлениеСпискаРасширений()
	
	СтрокаПоиска = "";
	ОбновитьСписокРасширений();
	ПоказатьОповещениеОЗагрузкеДанных(НСтр("ru = 'Обработка списка расширений'"));
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПодключениеКМенеджеруСервиса()
	
	Результат = ПодключитьсяКМенеджеруСервиса();
	ПоказатьОповещениеОЗагрузкеДанных(НСтр("ru = 'Подключение к Менеджеру сервиса...'"));
	
	Если Результат Тогда
		ПодключитьОбработчик();
	Иначе
		КодОшибки = 999;
		ТекстОшибки = НСтр("ru = 'Не удалось подключиться к Менеджеру сервиса.
							|Повторите попытку позднее или обратитесь к администратору сервиса.'");
		ОтобразитьИнформациюОбОшибке();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОповещениеОЗагрузкеДанных(Пояснение)
	
	Текст = НСтр("ru = 'Загрузка данных ...'");
	
	ПоказатьОповещениеПользователя(Текст,, Пояснение, БиблиотекаКартинок.Информация,, "ОбновлениеДанных");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатВыполненияЗапросаКМС()
	
	ДанныеХранилища = ПолучитьИзВременногоХранилища(АдресХранилищаРезультат);
	
	Если ДанныеХранилища = Неопределено Тогда
		ПодключитьОбработчик();
		Возврат;
	КонецЕсли;
	
	ИзменитьДоступностьПанели(Истина);
	ОтключитьОбработчикОжидания("ОбработатьРезультатВыполненияЗапросаКМС");	
	
	Если НЕ ДанныеХранилища.success Тогда
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Не удалось выполнить запрос'") + Символы.ПС 
			+ НСтр("ru = 'Код ошибки: %1'") + Символы.ПС 
			+ НСтр("ru = 'Описание: %2'"), ДанныеХранилища.error.code, ДанныеХранилища.error.msg);	
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	Если ДанныеХранилища.ИмяМетода = "ПолучитьСписокДоступныхРасширений" 
		ИЛИ ДанныеХранилища.ИмяМетода = "ПолучитьСписокНайденныхРасширений" Тогда
		
		ЕстьЕщеРасширения = ЗагрузитьДанныеРасширений(ДанныеХранилища.result);
		ИдентификаторыПоследнихРасширений.Вставить(ВариантСписка, ИдентификаторПоследнегоРасширения);
		
		Если НЕ ЕстьЕщеРасширения Тогда
			ПоказатьОповещениеОЗагрузкеДанных(НСтр("ru = 'Это все доступные расширения.'"));
		КонецЕсли;
		
	ИначеЕсли ДанныеХранилища.ИмяМетода = "ПолучитьСписокРазделов" Тогда
		ПоказатьРазделы(ДанныеХранилища);		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокРасширений(ЗагрузитьЕще = Ложь, ЭтоПоиск = Ложь, Знач СтрокаАвтоПодбора = Неопределено)
	
	Если ЭтоПоиск И СтрокаАвтоПодбора <> Неопределено Тогда
		ПоисковаяФраза = СтрокаАвтоПодбора;
	Иначе
		ПоисковаяФраза = СтрокаПоиска;
	КонецЕсли;
	
	Если ЭтоПоиск И ПредыдущаяПоисковаяФраза = ПоисковаяФраза Тогда
		Возврат;
	КонецЕсли;
	
	ПредыдущаяПоисковаяФраза = ПоисковаяФраза;
	
	Если НЕ ОбновитьНаСервере(
						ЗагрузитьЕще,
						ЭтоПоиск,
						СоответствиеТиповРазделам.Получить(ВариантСписка),
						АдресХранилищаРезультат,
						ИдентификаторПоследнегоРасширения,
						ТолькоУстановленные,
						ПоисковаяФраза) Тогда
		Возврат;
	КонецЕсли;
	
	ИзменитьДоступностьПанели(Ложь);

	ПодключитьОбработчик();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОбновитьНаСервере(ЗагрузитьЕще, ЭтоПоиск, МассивТиповДоступа, АдресХранилищаРезультат, ИдентификаторПоследнегоРасширения, ТолькоУстановленные, СтрокаПоиска)
	
	АдресХранилищаРезультат = ПоместитьВоВременноеХранилище(Неопределено, АдресХранилищаРезультат);
	
	Если НЕ ЗагрузитьЕще Тогда
		ИдентификаторПоследнегоРасширения = "";
	КонецЕсли;
		
	Если ЭтоПоиск И ПустаяСтрока(СтрокаПоиска) Тогда
		Возврат КаталогРасширений.ПолучитьДоступныеРасширенияВФоне(АдресХранилищаРезультат, МассивТиповДоступа, ИдентификаторПоследнегоРасширения,,, ТолькоУстановленные);
	ИначеЕсли ЭтоПоиск ИЛИ (ЗагрузитьЕще И НЕ ПустаяСтрока(СтрокаПоиска)) Тогда
		Возврат КаталогРасширений.ПолучитьНайденныеРасширенияВФоне(АдресХранилищаРезультат, МассивТиповДоступа, СтрокаПоиска, ИдентификаторПоследнегоРасширения,,, ТолькоУстановленные);
	Иначе
		Возврат КаталогРасширений.ПолучитьДоступныеРасширенияВФоне(АдресХранилищаРезультат, МассивТиповДоступа, ИдентификаторПоследнегоРасширения,,, ТолькоУстановленные);	
	КонецЕсли;
		
КонецФункции

&НаКлиенте
Функция ЗагрузитьДанныеРасширений(Знач МассивРасширений)
	
	ТекстЕще = НСтр("ru = 'Показать еще'");
	
	ПараметрыПоиска = Новый Структура;
	ПараметрыПоиска.Вставить("ПоказатьСледующиеРасширения", ТекстЕще);
	ПараметрыПоиска.Вставить("Раздел", ВариантСписка);
	
	СтрокиЕще = Расширения.НайтиСтроки(ПараметрыПоиска);
	
	Если СтрокиЕще.Количество() <> 0 Тогда
		Расширения.Удалить(СтрокиЕще[0]);
	КонецЕсли;
		
	Если НЕ ЗначениеЗаполнено(ИдентификаторПоследнегоРасширения) Тогда
		
		НайденныеСтроки = Расширения.НайтиСтроки(Новый Структура("Раздел", ВариантСписка));
		
		Для Каждого СтрокаДанных Из НайденныеСтроки Цикл
			Расширения.Удалить(СтрокаДанных);	
		КонецЦикла;
		
	КонецЕсли;
	
	Если МассивРасширений.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;
		
	ИдентификаторПоследнегоРасширения = МассивРасширений.Получить(МассивРасширений.ВГраница()).ИдентификаторРасширения;
	МаксимальноеКоличествоЭлементов = 0;
	
	Для Каждого ДанныеРасширения Из МассивРасширений Цикл
		
		НоваяСтрока = Расширения.Добавить();
		НоваяСтрока.Раздел = ВариантСписка;
		
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеРасширения);
		УстановитьКартинкиСтроки(НоваяСтрока);
		
		Если ЗначениеЗаполнено(НоваяСтрока.Превью) Тогда
			НоваяСтрока.Превью = ПоместитьВоВременноеХранилище(Base64Значение(НоваяСтрока.Превью), УникальныйИдентификатор);		
		КонецЕсли;
		
		НоваяСтрока.НаименованиеВерсии = СтрШаблон(НСтр("ru = 'Версия: %1'"), 
			НоваяСтрока.НаименованиеВерсии);
			
		НоваяСтрока.Разработчик = СтрШаблон(НСтр("ru = 'Разработчик: %1'"), 
			НоваяСтрока.Разработчик);

		НоваяСтрока.Состояние = СостояниеРасширения(НоваяСтрока.Состояние);
		
		Если ДанныеРасширения.Свойство("МаксимальноеКоличествоЭлементов") Тогда
			МаксимальноеКоличествоЭлементов = ДанныеРасширения.МаксимальноеКоличествоЭлементов;
		КонецЕсли;
		
	КонецЦикла;
	
	Если НЕ ТолькоУстановленные 
		И (МаксимальноеКоличествоЭлементов = 0 
			ИЛИ МассивРасширений.Количество() >= МаксимальноеКоличествоЭлементов) Тогда	
			
		НоваяСтрока = Расширения.Добавить();
		НоваяСтрока.ПоказатьСледующиеРасширения = ТекстЕще;
		НоваяСтрока.Раздел = ВариантСписка;
		
	КонецЕсли;
		
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ПодключитьОбработчик()
	ПодключитьОбработчикОжидания("ОбработатьРезультатВыполненияЗапросаКМС", 0.5, Истина);	
КонецПроцедуры

&НаСервере
Функция ПодключитьсяКМенеджеруСервиса()
	
	АдресХранилищаРезультат = ПоместитьВоВременноеХранилище(Неопределено, АдресХранилищаРезультат);
	Возврат КаталогРасширений.ПолучитьДанныеРазделовВФоне(АдресХранилищаРезультат);

КонецФункции

&НаКлиенте
Процедура ОтобразитьИнформациюОбОшибке(ДанныеХранилища = Неопределено)
	
	Если ДанныеХранилища <> Неопределено Тогда
		КодОшибки = ДанныеХранилища.error.code;
		ТекстОшибки = ДанныеХранилища.error.msg;
	КонецЕсли;
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаОшибка;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьРазделы(ДанныеХранилища)
	
	Если НЕ ДанныеХранилища.success Тогда
		ОтобразитьИнформациюОбОшибке(ДанныеХранилища);
		Возврат;
	КонецЕсли;
	
	Элементы.ВариантСписка.СписокВыбора.Очистить();
	СоответствиеТиповРазделам = Новый Соответствие;
	
	Для Каждого ДанныеРаздела Из ДанныеХранилища.result Цикл
		
		Элементы.ВариантСписка.СписокВыбора.Добавить(ДанныеРаздела.name, ДанныеРаздела.synonym);			
		СоответствиеТиповРазделам.Вставить(ДанныеРаздела.name, ДанныеРаздела.types);	
		
	КонецЦикла;
	
	Элементы.ГруппаВариантСписка.Видимость = Элементы.ВариантСписка.СписокВыбора.Количество() > 1;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаКаталог;
	
	ВариантСписка = Элементы.ВариантСписка.СписокВыбора[0].Значение;
	ИзменитьРаздел();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьРаздел()
	
	Элементы.Расширения.ОтборСтрок = Новый ФиксированнаяСтруктура("Раздел", ВариантСписка);
	
	СтрокиРасширений = Расширения.НайтиСтроки(Новый Структура("Раздел", ВариантСписка));
	
	Если СтрокиРасширений.Количество() = 0 ИЛИ ТолькоУстановленные Тогда
		
		НачатьОбновлениеСпискаРасширений();	
		Возврат;
			
	КонецЕсли;
	
	ИдентификаторПоследнегоРасширения = ИдентификаторыПоследнихРасширений.Получить(ВариантСписка); 
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СостояниеРасширения(Знач Состояние)
	Возврат СтрШаблон(НСтр("ru = 'Состояние: %1'"), Состояние);
КонецФункции

&НаКлиенте
Процедура УстановитьКартинкиСтроки(НоваяСтрока)
	
	Если НоваяСтрока.УсредненнаяОценка >= 1 Тогда
		НоваяСтрока.Оценка_1 = 0;
	Иначе
		НоваяСтрока.Оценка_1 = 2;
	КонецЕсли;
	
	Если НоваяСтрока.УсредненнаяОценка >= 2 Тогда
		НоваяСтрока.Оценка_2 = 0;
	ИначеЕсли НоваяСтрока.УсредненнаяОценка >= 1.5 Тогда
		НоваяСтрока.Оценка_2 = 1;
	Иначе
		НоваяСтрока.Оценка_2 = 2;
	КонецЕсли;
	
	Если НоваяСтрока.УсредненнаяОценка >= 3 Тогда
		НоваяСтрока.Оценка_3 = 0;
	ИначеЕсли НоваяСтрока.УсредненнаяОценка >= 2.5 Тогда
		НоваяСтрока.Оценка_3 = 1;
	Иначе
		НоваяСтрока.Оценка_3 = 2;
	КонецЕсли;
	
	Если НоваяСтрока.УсредненнаяОценка >= 4 Тогда
		НоваяСтрока.Оценка_4 = 0;
	ИначеЕсли НоваяСтрока.УсредненнаяОценка >= 3.5 Тогда
		НоваяСтрока.Оценка_4 = 1;
	Иначе
		НоваяСтрока.Оценка_4 = 2;
	КонецЕсли;
	
	Если НоваяСтрока.УсредненнаяОценка >= 5 Тогда
		НоваяСтрока.Оценка_5 = 0;
	ИначеЕсли НоваяСтрока.УсредненнаяОценка >= 4.5 Тогда
		НоваяСтрока.Оценка_5 = 1;
	Иначе
		НоваяСтрока.Оценка_5 = 2;
	КонецЕсли;
			
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьДоступностьПанели(Знач Доступна)
	
	Элементы.ГруппаВариантСписка.Доступность = Доступна;
	Элементы.ГруппаОбновить.Доступность = Доступна;
	Элементы.ТолькоУстановленные.Доступность = Доступна;
	
	Если НЕ Доступна Тогда
		Элементы.СтраницыРасширения.ТекущаяСтраница = Элементы.СтраницаПрогресс;
	Иначе
		Элементы.СтраницыРасширения.ТекущаяСтраница = Элементы.СтраницаРасширения;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти









