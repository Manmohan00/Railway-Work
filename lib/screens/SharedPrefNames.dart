
class SharedPrefName{
  static const  UserName= "UserName";
  static const Email = "Email";
  static const LoginStatus = "logInStatus";

}

class Months{
  static const Jan = 'January';
  static const Feb = 'February';
  static const Mar = 'March';
  static const Apr = 'April';
  static const May = 'May';
  static const June = 'June';
  static const July = 'July';
  static const August = 'August';
  static const Sept = 'September';
  static const Oct = 'October';
  static const Nov = 'November';
  static const Dec = 'December';
}


class WorkListName {
  static const ERC = 'ERC Oiling Greasing';
  static const MBS = 'MBC Sleeper Hauling';
  static const RH = 'Rail Hauling';
  static const Paint = 'Painting';
  static const ERCHeat = 'Seized ERC Removal by Heating';
  static const DressBox = 'Dressing Boxing, Bobyn Unloaded Ballast Clearance';
  static const Gas = 'Gas Cutting';
  static const NewMBC = 'New MBC Unloading';
  static const Crib = 'Crib Adjustment';
  static const TRRprep = 'TRR Preparation';
  static const TRR = 'TRR';
  static const Partner = 'Partner Cut';
  static const Drill = 'Drill';
  static const Destress = 'Destressing without';
  static const DestressTensor = 'Destressing TENSOR';
  static const Railunload = 'Rail Unloading';
  static const MBCReplace = 'MBC Sleeper Replacement';
  static const Lift = 'Lifting';
  static const Pack = 'Packing';
  static const Generate = 'Generator';
  static const SEJ = 'SEJ Insertion';
  static const RailPrep = 'Check Rail Preparation';
  static const LBR = 'LBR';
  static const Payment = 'PAYMENT for LBR Given';
  static const Extra = 'Extra';


  static const List workListALL = [ WorkListName.ERC,
    WorkListName.MBS,
    WorkListName.RH,
    WorkListName.Paint,
    WorkListName.ERCHeat,
    WorkListName.DressBox,
    WorkListName.Gas,
    WorkListName.NewMBC,
    WorkListName.Crib,
    WorkListName.TRRprep,
    WorkListName.TRR,
    WorkListName.Partner,
    WorkListName.Drill,
    WorkListName.Destress,
    WorkListName.DestressTensor,
    WorkListName.Railunload,
    WorkListName.MBCReplace,
    WorkListName.Lift,
    WorkListName.Pack,
    WorkListName.Generate,
    WorkListName.SEJ,
    WorkListName.RailPrep,
    WorkListName.LBR,
    WorkListName.Payment,
    WorkListName.Extra];
}

class WorkListShort{
  static const ERC = 'ERC';
  static const MBS = 'MBS';
  static const RH = 'RH';
  static const Paint = 'Paint';
  static const ERCHeat = 'ERCHeat';
  static const DressBox = 'DressBox';
  static const Gas = 'Gas';
  static const NewMBC = 'NewMBC';
  static const Crib = 'Crib';
  static const TRRprep = 'TRRprep';
  static const TRR = 'TRR';
  static const Partner = 'Partner';
  static const Drill = 'Drill';
  static const Destress = 'Destress';
  static const DestressTensor = 'DestressTensor';
  static const Railunload = 'Railunload';
  static const MBCReplace = 'MBCReplace';
  static const Lift = 'Lift';
  static const Pack = 'Pack';
  static const SEJ = 'SEJ';
  static const Generate = 'Generate';
  static const RailPrep  ='RailPrep';
  static const LBR = 'LBR';
  static const Payment = 'Payment';
  static const Extra = 'Extra';

  static const List workListALL = [ WorkListShort.ERC,
    WorkListShort.MBS,
    WorkListShort.RH,
    WorkListShort.Paint,
    WorkListShort.ERCHeat,
    WorkListShort.DressBox,
    WorkListShort.Gas,
    WorkListShort.NewMBC,
    WorkListShort.Crib,
    WorkListShort.TRRprep,
    WorkListShort.TRR,
    WorkListShort.Partner,
    WorkListShort.Drill,
    WorkListShort.Destress,
    WorkListShort.DestressTensor,
    WorkListShort.Railunload,
    WorkListShort.MBCReplace,
    WorkListShort.Lift,
    WorkListShort.Pack,
    WorkListShort.Generate,
    WorkListShort.SEJ,
    WorkListShort.RailPrep,
    WorkListShort.LBR,
    WorkListShort.Payment,
    WorkListShort.Extra];
}


class FirebaseNames{
  static const String subcollection ='Work_done';
  static const String nos = 'Work_Nos';
  static const String comment = 'Work_CMT';
  static const String Added = 'Work_Added';
  static const String work = 'Work';
  static const String road = 'Work_ROAD';
//  static const String loop = 'Work_LOOP';

  static const String roadup = 'UpRoad';
  static const String roadmid = 'MidRoad';
  static const String roaddown = 'DownRoad';

  static const String loopup = 'UpLoop';
  static const String loopmid = 'MidLoop';
  static const String loopdown = 'DownLoop';
}