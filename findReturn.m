function[stockReturn] = findReturn(dailyClosing, previousDayClosing)

stockReturn = 100 * (log10(dailyClosing) - log10(previousDayClosing));