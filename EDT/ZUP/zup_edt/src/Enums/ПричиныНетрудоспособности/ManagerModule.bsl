#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает Истина если причина нетрудоспособности является уходом за родственниками.
Функция ЭтоУходЗаРодственником(ПричинаНетрудоспособности) Экспорт
	Возврат ПричинаНетрудоспособности = ПоУходуЗаВзрослым
		Или ПричинаНетрудоспособности = ПоУходуЗаРебенком;
КонецФункции

// Возвращает Истина если в случае пересечения с отпуском должен оплачиваться отпуск.
Функция ОтпускВытесняетБольничный(ПричинаНетрудоспособности) Экспорт
	Возврат ПричинаНетрудоспособности = Карантин
		Или ПричинаНетрудоспособности = ПоУходуЗаРебенком
		Или ПричинаНетрудоспособности = ПоУходуЗаВзрослым;
КонецФункции

// Возвращает массив причин нетрудоспособности, вытесняемых отпуском.
Функция ПричиныВытесняемыеОтпуском() Экспорт
	Массив = Новый Массив;
	Массив.Добавить(Карантин);
	Массив.Добавить(ПоУходуЗаРебенком);
	Массив.Добавить(ПоУходуЗаВзрослым);
	Возврат Массив;
КонецФункции

// Возвращает представление причины нетрудоспособности без кода.
Функция ПредставлениеБезКода(ПричинаНетрудоспособности) Экспорт
	ПредставлениеПричины = Строка(ПричинаНетрудоспособности);
	Возврат СокрЛ(Сред(ПредставлениеПричины, СтрНайти(ПредставлениеПричины, ")") + 1));
КонецФункции

#КонецОбласти

#КонецЕсли