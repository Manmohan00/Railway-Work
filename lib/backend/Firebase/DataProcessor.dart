

import 'package:railway_work_tracking/backend/Firebase/WorkDataModel.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

String dateChange(date){
  return date.replaceAll(Months.Jan,'01').replaceAll(Months.Feb, '02')
      .replaceAll(Months.Mar, '03')
      .replaceAll(Months.Apr, '04')
      .replaceAll(Months.May, '05')
      .replaceAll(Months.June, '06')
      .replaceAll(Months.July, '07')
      .replaceAll(Months.August, '08')
      .replaceAll(Months.Sept, '09')
      .replaceAll(Months.Oct, '10')
      .replaceAll(Months.Nov, '11')
      .replaceAll(Months.Dec,'12');
}

String ShortenWorkName(workName){
  return workName.replaceAll(WorkListName.ERC, WorkListShort.ERC)
      .replaceAll(WorkListName.MBS, WorkListShort.MBS)
      .replaceAll(WorkListName.RH, WorkListShort.RH)
      .replaceAll(WorkListName.Paint, WorkListShort.Paint).
  replaceAll(WorkListName.ERCHeat, WorkListShort.ERCHeat)
      .replaceAll(WorkListName.DressBox, WorkListShort.DressBox)
      .replaceAll(WorkListName.Gas, WorkListShort.Gas)
      .replaceAll(WorkListName.NewMBC, WorkListShort.NewMBC)
      .replaceAll(WorkListName.Crib, WorkListShort.Crib)
      .replaceAll(WorkListName.TRRprep, WorkListShort.TRRprep)
      .replaceAll(WorkListName.TRR, WorkListShort.TRR)
      .replaceAll(WorkListName.Partner, WorkListShort.Partner)
      .replaceAll(WorkListName.Drill, WorkListShort.Drill)
      .replaceAll(WorkListName.Destress, WorkListShort.Destress)
      .replaceAll(WorkListName.DestressTensor, WorkListShort.DestressTensor)
      .replaceAll(WorkListName.Railunload, WorkListShort.Railunload)
      .replaceAll(WorkListName.MBCReplace, WorkListShort.MBCReplace)
      .replaceAll(WorkListName.Lift, WorkListShort.Lift)
      .replaceAll(WorkListName.Pack, WorkListShort.Pack)
      .replaceAll(WorkListName.Generate, WorkListShort.Generate)
      .replaceAll(WorkListName.SEJ, WorkListShort.SEJ)
      .replaceAll(WorkListName.RailPrep, WorkListShort.RailPrep)
      .replaceAll(WorkListName.LBR, WorkListShort.LBR)
      .replaceAll(WorkListName.Payment, WorkListShort.Payment)
      .replaceAll(WorkListName.Extra, WorkListShort.Extra);
}

