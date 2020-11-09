
#Область ПрограммныйИнтерфейс

// Вызывается при определении сервисов, которые поддерживают миграцию.
//
// Параметры:
//   Сервисы - СписокЗначений - в качестве значения адрес сервиса, в качестве представления - представление сервиса.
//
//@skip-warning Пустой метод
Процедура ПриОпределенииСервисов(Сервисы) Экспорт
	
КонецПроцедуры

// Обработчик при выгрузке данных.
//
// Параметры:
//   Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект, ПланСчетовОбъект,
//			ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей, РегистрРасчетаНаборЗаписей,
//			ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей, БизнесПроцессОбъект, ЗадачаОбъект - выгружаемый объект.
//   Отказ - Булево - если данному параметру установить значение Истина, то объект не будет выгружен.
//
//@skip-warning Пустой метод
Процедура ПриВыгрузкеОбъекта(Объект, Отказ) Экспорт
	
КонецПроцедуры

// Обработчик при загрузке данных.
//
// Параметры:
//   Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект, ПланСчетовОбъект,
//			ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей, РегистрРасчетаНаборЗаписей,
//			ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей, БизнесПроцессОбъект, ЗадачаОбъект - загружаемый объект.
//   Отказ - Булево - если данному параметру установить значение Истина, то объект не будет загружен.
//
//@skip-warning Пустой метод
Процедура ПриЗагрузкеОбъекта(Объект, Отказ) Экспорт
	
КонецПроцедуры

#КонецОбласти
	
