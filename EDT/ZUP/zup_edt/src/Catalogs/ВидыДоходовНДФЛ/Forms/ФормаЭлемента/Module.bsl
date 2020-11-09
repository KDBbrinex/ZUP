
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
		
		СсылкаНаОбъект = ОбщегоНазначения.МенеджерОбъектаПоСсылке(Объект.Ссылка).ПолучитьСсылку();
		РедактированиеПериодическихСведений.ИнициализироватьЗаписьДляРедактированияВФорме(ЭтаФорма, "ВычетыПоДоходамНДФЛ", СсылкаНаОбъект);
		РедактированиеПериодическихСведений.ИнициализироватьЗаписьДляРедактированияВФорме(ЭтаФорма, "РедактируемыеРеквизитыКодаДоходаНДФЛ", СсылкаНаОбъект);
		
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	РедактированиеПериодическихСведенийКлиент.ОбработкаОповещения(ЭтаФорма, СсылкаНаОбъект, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	СсылкаНаОбъект = Объект.Ссылка;
	ПрочитатьВычетыПоДоходамНДФЛ();
	ПрочитатьРедактируемыеРеквизитыКодаДоходаНДФЛ();
	УстановитьДоступностьСвойстваСоответствуетОплатеТруда();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Параметры.Ключ.Пустая() Тогда
		ТекущийОбъект.УстановитьСсылкуНового(СсылкаНаОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаписатьВычетыПоДоходамНДФЛ(ТекущийОбъект);
	ЗаписатьРедактируемыеРеквизитыКодаДоходаНДФЛ();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ПрочитатьВычетыПоДоходамНДФЛ();
	ПрочитатьРедактируемыеРеквизитыКодаДоходаНДФЛ();
	УстановитьДоступностьСвойстваСоответствуетОплатеТруда();
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	РедактированиеПериодическихСведений.ПроверитьЗаписьВФорме(ЭтаФорма, "ВычетыПоДоходамНДФЛ", СсылкаНаОбъект, Отказ);
	РедактированиеПериодическихСведений.ПроверитьЗаписьВФорме(ЭтаФорма, "РедактируемыеРеквизитыКодаДоходаНДФЛ", СсылкаНаОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВычетыПоДоходамНДФЛПериодРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Направление > 0 Тогда
		ВычетыПоДоходамНДФЛ.Период = КонецГода(ВычетыПоДоходамНДФЛ.Период) + 1;
	Иначе
		ВычетыПоДоходамНДФЛ.Период = НачалоГода(НачалоГода(ВычетыПоДоходамНДФЛ.Период) - 1);
	КонецЕсли;
	
	Если ВычетыПоДоходамНДФЛ.Период < '20100101' Тогда
		ВычетыПоДоходамНДФЛ.Период = '20100101'
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура РедактируемыеРеквизитыКодаДоходаНДФЛСоответствуетОплатеТрудаПриИзменении(Элемент)
	
	Модифицированность = Истина;
	РедактированиеПериодическихСведенийКлиентСервер.ОбновитьОтображениеПолейВвода(ЭтаФорма, "РедактируемыеРеквизитыКодаДоходаНДФЛ", СсылкаНаОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВычетыПоДоходамНДФЛИстория(Команда)
	
	РедактированиеПериодическихСведенийКлиент.ОткрытьИсторию("ВычетыПоДоходамНДФЛ", СсылкаНаОбъект, ЭтаФорма, ТолькоПросмотр);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписатьИЗакрыть(Команда)
	
	ЗаписатьНаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписать(Команда)
	
	ЗаписатьНаКлиенте(Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПрочитатьВычетыПоДоходамНДФЛ()
	
	РедактированиеПериодическихСведений.ПрочитатьЗаписьДляРедактированияВФорме(ЭтаФорма, "ВычетыПоДоходамНДФЛ", СсылкаНаОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьВычетыПоДоходамНДФЛ(ТекущийОбъект)
	
	РедактированиеПериодическихСведений.ЗаписатьЗаписьПослеРедактированияВФорме(ЭтаФорма, "ВычетыПоДоходамНДФЛ", ТекущийОбъект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведений(ИмяРегистра, ВедущийОбъект) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписей(ЭтаФорма, ИмяРегистра, ВедущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьРедактируемыеРеквизитыКодаДоходаНДФЛ()
	
	РедактированиеПериодическихСведений.ПрочитатьЗаписьДляРедактированияВФорме(ЭтаФорма, "РедактируемыеРеквизитыКодаДоходаНДФЛ", СсылкаНаОбъект);
	
КонецПроцедуры

&НаСервере
Функция ЗаписатьРедактируемыеРеквизитыКодаДоходаНДФЛ()
	
	ИзменилисьДанные = РедактированиеПериодическихСведений.ЗаписатьЗаписьПослеРедактированияВФорме(ЭтаФорма, "РедактируемыеРеквизитыКодаДоходаНДФЛ", СсылкаНаОбъект);
	
	Если ИзменилисьДанные Тогда
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
	Возврат ИзменилисьДанные;
	
КонецФункции

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведенийПоСтруктуре(ИмяРегистра, СтруктураВедущихОбъектов) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписейПоСтруктуре(ЭтаФорма, ИмяРегистра, СтруктураВедущихОбъектов);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьСвойстваСоответствуетОплатеТруда()
	
	ВидыДоходов = Справочники.ВидыДоходовНДФЛ.ДоступноСвойствоСоответствуетОплатеТруда();
	Если ВидыДоходов.Найти(Объект.Ссылка) <> Неопределено Тогда 
		ДоступенТолькоПросмотр = Ложь;
	Иначе 
		СоответствуетОплатеТрудаПоУмолчанию = Ложь;
		ВидыДоходовСоответствующиеОплатеТруда = Справочники.ВидыДоходовНДФЛ.ВидыДоходовСоответствующиеОплатеТруда();
		Если ВидыДоходовСоответствующиеОплатеТруда.Найти(Объект.Ссылка) <> Неопределено Тогда 
			СоответствуетОплатеТрудаПоУмолчанию = Истина;
		КонецЕсли;
		ДоступенТолькоПросмотр = СоответствуетОплатеТрудаПоУмолчанию = РедактируемыеРеквизитыКодаДоходаНДФЛ.СоответствуетОплатеТруда;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, 
		"РедактируемыеРеквизитыКодаДоходаНДФЛСоответствуетОплатеТруда", "ТолькоПросмотр", ДоступенТолькоПросмотр);
	
КонецПроцедуры

#Область ЗаписьЭлемента

&НаКлиенте
Процедура ЗаписатьНаКлиенте(ЗакрытьПослеЗаписи, ОповещениеЗавершения = Неопределено) Экспорт 
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ЗакрытьПослеЗаписи", ЗакрытьПослеЗаписи);
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
	
	Оповещение = Новый ОписаниеОповещения("ЗаписатьНаКлиентеЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ТекстКнопкиДа = НСтр("ru = 'Изменились сведения о территориальных условиях ПФР'");
	ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'При редактировании Вы изменили сведения о соответствии вида дохода оплате труда.
		|Если Вы исправили прежние сведения о соответствии оплате труда (они были ошибочными), нажмите ""%1"".'"), 
		ТекстКнопкиДа);
	
	РедактированиеПериодическихСведенийКлиент.ЗапроситьРежимИзмененияРегистра(ЭтаФорма,"РедактируемыеРеквизитыКодаДоходаНДФЛ", ТекстВопроса, ТекстКнопкиДа, Ложь, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНаКлиентеЗавершение(Отказ, ДополнительныеПараметры) Экспорт 
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыЗаписи = Новый Структура("ПроверкаПередЗаписьюВыполнена", Истина);
	
	Если ДополнительныеПараметры.ОповещениеЗавершения <> Неопределено Тогда 
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеЗавершения, ПараметрыЗаписи);
	Иначе
		ЗаписатьНаСервере(Не ДополнительныеПараметры.ЗакрытьПослеЗаписи);
		
		Оповестить("ИзмененКодДоходаНДФЛ", , СсылкаНаОбъект);
		
		Если ДополнительныеПараметры.ЗакрытьПослеЗаписи Тогда
			Закрыть();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере(НеЗакрыватьФорму = Истина)
	
	Если ЗаписатьРедактируемыеРеквизитыКодаДоходаНДФЛ() И НеЗакрыватьФорму Тогда
		ПрочитатьРедактируемыеРеквизитыКодаДоходаНДФЛ();
		УстановитьДоступностьСвойстваСоответствуетОплатеТруда();
	КонецЕсли;
	
	Модифицированность = Ложь;
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти
