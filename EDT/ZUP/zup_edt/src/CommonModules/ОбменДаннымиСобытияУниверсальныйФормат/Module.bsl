////////////////////////////////////////////////////////////////////////////////
// Обмен данными через универсальный формат Enterprise Data.
// Серверные процедуры и функции, обслуживающие подписки на события.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура СинхронизацияДанныхЧерезУниверсальныйФорматПередЗаписью(Источник, Отказ) Экспорт
	
	// ОбменДанными.Загрузка не требуется, т.к. подписка относится к плану обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("СинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ);
	
КонецПроцедуры

Процедура СинхронизацияДанныхЧерезУниверсальныйФорматПередЗаписьюДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// ОбменДанными.Загрузка не требуется, т.к. подписка относится к плану обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("СинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

Процедура СинхронизацияДанныхЧерезУниверсальныйФорматПередУдалением(Источник, Отказ) Экспорт
	
	// ОбменДанными.Загрузка не требуется, т.к. подписка относится к плану обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("СинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ);
	
КонецПроцедуры

Процедура СинхронизацияДанныхЧерезУниверсальныйФорматПередЗаписьюНабораЗаписей(Источник, Отказ, Замещение) Экспорт
	
	// ОбменДанными.Загрузка не требуется, т.к. подписка относится к плану обмена.
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("СинхронизацияДанныхЧерезУниверсальныйФормат", Источник, Отказ, Замещение);
	
КонецПроцедуры

#КонецОбласти
