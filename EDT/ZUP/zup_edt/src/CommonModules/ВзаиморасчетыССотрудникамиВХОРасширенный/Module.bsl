#Область СлужебныйПрограммныйИнтерфейс

#Область Свойства

// См. УправлениеСвойствамиПереопределяемый.ПриПолученииПредопределенныхНаборовСвойств.
Процедура ПриПолученииПредопределенныхНаборовСвойств(Наборы) Экспорт
	
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbf14-9802-11e9-80cd-4cedfb43b11a", Метаданные.Документы.ВозвратСотрудникомЗадолженности);
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbf9c-9802-11e9-80cd-4cedfb43b11a", Метаданные.Документы.СведенияОНезачисленнойЗарплате);
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииСписковСОграничениемДоступа(Списки) Экспорт
	
	Списки.Вставить(Метаданные.Документы.ПлатежноеПоручение, Истина);
	Списки.Вставить(Метаданные.Справочники.ПлатежноеПоручениеПрисоединенныеФайлы, Истина);
	Списки.Вставить(Метаданные.Документы.ВозвратСотрудникомЗадолженности, Истина);
	Списки.Вставить(Метаданные.Справочники.ВозвратСотрудникомЗадолженностиПрисоединенныеФайлы, Истина);
	Списки.Вставить(Метаданные.Документы.СведенияОНезачисленнойЗарплате, Истина);
	Списки.Вставить(Метаданные.Справочники.СведенияОНезачисленнойЗарплатеПрисоединенныеФайлы, Истина);
	
КонецПроцедуры

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииВидовОграниченийПравОбъектовМетаданных.
Процедура ПриЗаполненииВидовОграниченийПравОбъектовМетаданных(Описание) Экспорт

		Описание = Описание + "
		|Документ.ПлатежноеПоручение.Чтение.Организации
		|Документ.ПлатежноеПоручение.Изменение.Организации
		|Справочник.ПлатежноеПоручениеПрисоединенныеФайлы.Чтение.Организации
		|Справочник.ПлатежноеПоручениеПрисоединенныеФайлы.Изменение.Организации
		|Документ.ВозвратСотрудникомЗадолженности.Чтение.ГруппыФизическихЛиц
		|Документ.ВозвратСотрудникомЗадолженности.Чтение.Организации
		|Документ.ВозвратСотрудникомЗадолженности.Изменение.ГруппыФизическихЛиц
		|Документ.ВозвратСотрудникомЗадолженности.Изменение.Организации
		|Справочник.ВозвратСотрудникомЗадолженностиПрисоединенныеФайлы.Чтение.ГруппыФизическихЛиц
		|Справочник.ВозвратСотрудникомЗадолженностиПрисоединенныеФайлы.Чтение.Организации
		|Справочник.ВозвратСотрудникомЗадолженностиПрисоединенныеФайлы.Изменение.ГруппыФизическихЛиц
		|Справочник.ВозвратСотрудникомЗадолженностиПрисоединенныеФайлы.Изменение.Организации
		|Документ.СведенияОНезачисленнойЗарплате.Чтение.ГруппыФизическихЛиц
		|Документ.СведенияОНезачисленнойЗарплате.Чтение.Организации
		|Документ.СведенияОНезачисленнойЗарплате.Изменение.ГруппыФизическихЛиц
		|Документ.СведенияОНезачисленнойЗарплате.Изменение.Организации
		|Справочник.СведенияОНезачисленнойЗарплатеПрисоединенныеФайлы.Чтение.ГруппыФизическихЛиц
		|Справочник.СведенияОНезачисленнойЗарплатеПрисоединенныеФайлы.Чтение.Организации
		|Справочник.СведенияОНезачисленнойЗарплатеПрисоединенныеФайлы.Изменение.ГруппыФизическихЛиц
		|Справочник.СведенияОНезачисленнойЗарплатеПрисоединенныеФайлы.Изменение.Организации";
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Добавляет в список Обработчики процедуры-обработчики обновления,
// необходимые данной подсистеме.
//
// Параметры:
//   Обработчики - ТаблицаЗначений - см. описание функции НоваяТаблицаОбработчиковОбновления
//                                   общего модуля ОбновлениеИнформационнойБазы.
// 
Процедура ЗарегистрироватьОбработчикиОбновления(Обработчики) Экспорт
	
КонецПроцедуры	

// Определяет объекты, в которых есть процедура ДобавитьКомандыПечати().
// Подробнее см. УправлениеПечатьюПереопределяемый.
//
// Параметры:
//  СписокОбъектов - Массив - список менеджеров объектов.
//
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Документы.ВозвратСотрудникомЗадолженности);
	СписокОбъектов.Добавить(Документы.СведенияОНезачисленнойЗарплате);

	
КонецПроцедуры

#КонецОбласти