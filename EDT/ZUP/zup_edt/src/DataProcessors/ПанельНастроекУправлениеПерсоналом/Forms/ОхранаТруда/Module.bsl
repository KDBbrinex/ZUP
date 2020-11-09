#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПрочитатьНастройки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НастройкиСпециальнойОценкиУсловийТрудаИспользоватьСпециальнуюОценкуУсловийТрудаПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("НастройкиСпециальнойОценкиУсловийТруда");
	
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиНесчастныхСлучаевНаПроизводствеИспользоватьНесчастныеСлучаиНаПроизводствеПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("НастройкиНесчастныхСлучаевНаПроизводстве");
	
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиИнструктажейПоОхранеТрудаИспользоватьИнструктажиПоОхранеТрудаПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьИнструктажиПоОхранеТруда");
	
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьМедицинскиеОсмотрыПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьМедицинскиеОсмотры");
	
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПрочитатьНастройки()
	
	Настройки = РегистрыСведений.НастройкиСпециальнойОценкиУсловийТруда.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	ЗначениеВРеквизитФормы(Настройки, "НастройкиСпециальнойОценкиУсловийТруда");
	
	Настройки = РегистрыСведений.НастройкиНесчастныхСлучаевНаПроизводстве.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	ЗначениеВРеквизитФормы(Настройки, "НастройкиНесчастныхСлучаевНаПроизводстве");
	
	ИспользоватьИнструктажиПоОхранеТруда = Константы.ИспользоватьИнструктажиПоОхранеТруда.Получить();
	ИспользоватьМедицинскиеОсмотры = Константы.ИспользоватьМедицинскиеОсмотры.Получить();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьОбработчикОжиданияОбновленияИнтерфейса() Экспорт
	
	ТребуетсяОбновлениеИнтерфейса = Истина;
	
	#Если НЕ ВебКлиент Тогда
		ПодключитьОбработчикОжидания("ОбработчикОжиданияОбновленияИнтерфейса", 1, Истина);
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте 
Процедура ОбработчикОжиданияОбновленияИнтерфейса()
	
	ОбновитьИнтерфейс();
	
	ТребуетсяОбновлениеИнтерфейса = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНастройкиНаКлиенте(ИмяНастройки)
	
	ЗаписатьНастройкиНаСервере(ИмяНастройки);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНастройкиНаСервере(ИмяНастройки)
	
	ПараметрыНастроек = Обработки.ПанельНастроекУправлениеПерсоналом.ЗаполнитьСтруктуруПараметровНастроек(ИмяНастройки);
	
	ПараметрыНастроек.НастройкиСпециальнойОценкиУсловийТруда = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиСпециальнойОценкиУсловийТруда, Метаданные.РегистрыСведений.НастройкиСпециальнойОценкиУсловийТруда);
	ПараметрыНастроек.НастройкиНесчастныхСлучаевНаПроизводстве = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиНесчастныхСлучаевНаПроизводстве, Метаданные.РегистрыСведений.НастройкиНесчастныхСлучаевНаПроизводстве);
	ПараметрыНастроек.ИспользоватьИнструктажиПоОхранеТруда = ИспользоватьИнструктажиПоОхранеТруда;
	ПараметрыНастроек.ИспользоватьМедицинскиеОсмотры = ИспользоватьМедицинскиеОсмотры;
	
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
	Обработки.ПанельНастроекУправлениеПерсоналом.ЗаписатьНастройки(ПараметрыНастроек, АдресХранилища);
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

#КонецОбласти
