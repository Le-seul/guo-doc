package cn.gov.gaj.phms.v3;

import java.util.List;


interface ITodayStepDBHelper {

    void createTable();

    void deleteTable();

    void clearCapacity(String curDate, int limit);

    boolean isExist(TodayStepData todayStepData);

    void insert(TodayStepData todayStepData);

    TodayStepData getMaxStepByDate(long millis);

    List<TodayStepData> getQueryAll();

    List<TodayStepData> getStepListByDate(String dateString);

    List<TodayStepData> getStepListByStartDateAndDays(String startDate, int days);
}
