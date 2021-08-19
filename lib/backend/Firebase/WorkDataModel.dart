

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_work_tracking/screens/SharedPrefNames.dart';

class WorkData{
  Timestamp date;
  bool create;

  WorkData({required this.date, required this.create});

  WorkData.toJson(Map<String,dynamic> Date):
      date = Date['Time'],
      create = Date['Created'];

}

class WorkQuantity{
  String ERC;
  String MBS;
  String RH;
  String Paint;
  String ERCHeat;
  String DressBox;
  String Gas;
  String NewMBC;
  String Crib;
  String TRRprep;
  String TRR;
  String Partner;
  String Drill;
  String Destress;
  String DestressTensor;
  String Railunload;
  String MBCReplace;
  String Lift;
  String Pack;
  String Generate;
  String SEJ;
  String RailPrep;
  String LBR;
  String Payment;
  String Extra;

  WorkQuantity({required this.ERC,
    required this.MBS,
    required this.RH,
    required this.Paint,
    required this.ERCHeat,
    required this.DressBox,
    required this.Gas,
    required this.NewMBC,
    required this.Crib,
    required this.TRRprep,
    required this.TRR,
    required this.Partner,
    required this.Drill,
    required this.Destress,
    required this.DestressTensor,
    required this.Railunload,
    required this.MBCReplace,
    required this.Lift,
    required this.Pack,
    // ignore: non_constant_identifier_names
    required this.Generate,
    required this.SEJ,
    required this.RailPrep,
    required this.LBR,
    required this.Payment,
    required this.Extra
  });



  WorkQuantity.toJson(Map<String,dynamic> quantity):

  ERC = quantity["${WorkListShort.ERC}-Nos"] ?? 'none',
  MBS = quantity["${WorkListShort.MBS}-Nos"] ?? 'none',
  RH = quantity["${WorkListShort.RH}-Nos"] ?? 'none',
  Paint = quantity["${WorkListShort.Paint}-Nos"] ?? 'none',
  ERCHeat = quantity["${WorkListShort.ERCHeat}-Nos"] ?? 'none',
  DressBox = quantity["${WorkListShort.DressBox}-Nos"] ?? 'none',
  Gas = quantity["${WorkListShort.Gas}-Nos"] ?? 'none',
  NewMBC = quantity["${WorkListShort.NewMBC}-Nos"] ?? 'none',
  Crib = quantity["${WorkListShort.Crib}-Nos"]?? 'none',
  TRRprep =quantity["${WorkListShort.TRRprep}-Nos"]?? 'none',
  TRR = quantity["${WorkListShort.TRR}-Nos"]?? 'none',
  Partner = quantity["${WorkListShort.Partner}-Nos"]?? 'none',
  Drill = quantity["${WorkListShort.Drill}-Nos"]?? 'none',
  Destress = quantity["${WorkListShort.Destress}-Nos"]?? 'none',
  DestressTensor = quantity["${WorkListShort.DestressTensor}-Nos"]?? 'none',
  Railunload = quantity["${WorkListShort.Railunload}-Nos"]?? 'none',
  MBCReplace = quantity["${WorkListShort.MBCReplace}-Nos"]?? 'none',
  Lift = quantity["${WorkListShort.Lift}-Nos"]?? 'none',
  Pack = quantity["${WorkListShort.Pack}-Nos"]?? 'none',
  Generate = quantity["${WorkListShort.Generate}-Nos"]?? 'none',
  SEJ = quantity["${WorkListShort.SEJ}-Nos"]?? 'none',
  RailPrep = quantity["${WorkListShort.RailPrep}-Nos"]?? 'none',
  LBR = quantity["${WorkListShort.LBR}-Nos"]?? 'none',
  Payment = quantity["${WorkListShort.Payment}-Nos"]?? 'none',
  Extra = quantity["${WorkListShort.Extra}-Nos"]?? 'none';

  }

class WorkAddedbyUser{
  String ERC;
  String MBS;
  String RH;
  String Paint;
  String ERCHeat;
  String DressBox;
  String Gas;
  String NewMBC;
  String Crib;
  String TRRprep;
  String TRR;
  String Partner;
  String Drill;
  String Destress;
  String DestressTensor;
  String Railunload;
  String MBCReplace;
  String Lift;
  String Pack;
  String Generate;
  String SEJ;
  String RailPrep;
  String LBR;
  String Payment;
  String Extra;

  WorkAddedbyUser({required this.ERC,
    required this.MBS,
    required this.RH,
    required this.Paint,
    required this.ERCHeat,
    required this.DressBox,
    required this.Gas,
    required this.NewMBC,
    required this.Crib,
    required this.TRRprep,
    required this.TRR,
    required this.Partner,
    required this.Drill,
    required this.Destress,
    required this.DestressTensor,
    required this.Railunload,
    required this.MBCReplace,
    required this.Lift,
    required this.Pack,
    // ignore: non_constant_identifier_names
    required this.Generate,
    required this.SEJ,
    required this.RailPrep,
    required this.LBR,
    required this.Payment,
    required this.Extra
  });



  WorkAddedbyUser.toJson(Map<String,dynamic> user):

        ERC = user["${WorkListShort.ERC}_Added"] ?? 'none',
        MBS = user["${WorkListShort.MBS}_Added"] ?? 'none',
        RH = user["${WorkListShort.RH}_Added"] ?? 'none',
        Paint = user["${WorkListShort.Paint}_Added"] ?? 'none',
        ERCHeat = user["${WorkListShort.ERCHeat}_Added"] ?? 'none',
        DressBox = user["${WorkListShort.DressBox}_Added"] ?? 'none',
        Gas = user["${WorkListShort.Gas}_Added"] ?? 'none',
        NewMBC = user["${WorkListShort.NewMBC}_Added"] ?? 'none',
        Crib = user["${WorkListShort.Crib}_Added"]?? 'none',
        TRRprep =user["${WorkListShort.TRRprep}_Added"]?? 'none',
        TRR = user["${WorkListShort.TRR}_Added"]?? 'none',
        Partner = user["${WorkListShort.Partner}_Added"]?? 'none',
        Drill = user["${WorkListShort.Drill}_Added"]?? 'none',
        Destress = user["${WorkListShort.Destress}_Added"]?? 'none',
        DestressTensor = user["${WorkListShort.DestressTensor}_Added"]?? 'none',
        Railunload = user["${WorkListShort.Railunload}_Added"]?? 'none',
        MBCReplace = user["${WorkListShort.MBCReplace}_Added"]?? 'none',
        Lift = user["${WorkListShort.Lift}_Added"]?? 'none',
        Pack = user["${WorkListShort.Pack}_Added"]?? 'none',
        Generate = user["${WorkListShort.Generate}_Added"]?? 'none',
        SEJ = user["${WorkListShort.SEJ}_Added"]?? 'none',
        RailPrep = user["${WorkListShort.RailPrep}_Added"]?? 'none',
        LBR = user["${WorkListShort.LBR}_Added"]?? 'none',
        Payment = user["${WorkListShort.Payment}_Added"]?? 'none',
        Extra = user["${WorkListShort.Extra}_Added"]?? 'none';

}

class WorkComment{
  String ERC;
  String MBS;
  String RH;
  String Paint;
  String ERCHeat;
  String DressBox;
  String Gas;
  String NewMBC;
  String Crib;
  String TRRprep;
  String TRR;
  String Partner;
  String Drill;
  String Destress;
  String DestressTensor;
  String Railunload;
  String MBCReplace;
  String Lift;
  String Pack;
  String Generate;
  String SEJ;
  String RailPrep;
  String LBR;
  String Payment;
  String Extra;

  WorkComment({required this.ERC,
    required this.MBS,
    required this.RH,
    required this.Paint,
    required this.ERCHeat,
    required this.DressBox,
    required this.Gas,
    required this.NewMBC,
    required this.Crib,
    required this.TRRprep,
    required this.TRR,
    required this.Partner,
    required this.Drill,
    required this.Destress,
    required this.DestressTensor,
    required this.Railunload,
    required this.MBCReplace,
    required this.Lift,
    required this.Pack,
    // ignore: non_constant_identifier_names
    required this.Generate,
    required this.SEJ,
    required this.RailPrep,
    required this.LBR,
    required this.Payment,
    required this.Extra
  });



  WorkComment.toJson(Map<String,dynamic> user):

        ERC = user["${WorkListShort.ERC}-CMT"] ?? 'none',
        MBS = user["${WorkListShort.MBS}-CMT"] ?? 'none',
        RH = user["${WorkListShort.RH}-CMT"] ?? 'none',
        Paint = user["${WorkListShort.Paint}-CMT"] ?? 'none',
        ERCHeat = user["${WorkListShort.ERCHeat}-CMT"] ?? 'none',
        DressBox = user["${WorkListShort.DressBox}-CMT"] ?? 'none',
        Gas = user["${WorkListShort.Gas}-CMT"] ?? 'none',
        NewMBC = user["${WorkListShort.NewMBC}-CMT"] ?? 'none',
        Crib = user["${WorkListShort.Crib}-CMT"]?? 'none',
        TRRprep =user["${WorkListShort.TRRprep}-CMT"]?? 'none',
        TRR = user["${WorkListShort.TRR}-CMT"]?? 'none',
        Partner = user["${WorkListShort.Partner}-CMT"]?? 'none',
        Drill = user["${WorkListShort.Drill}-CMT"]?? 'none',
        Destress = user["${WorkListShort.Destress}-CMT"]?? 'none',
        DestressTensor = user["${WorkListShort.DestressTensor}-CMT"]?? 'none',
        Railunload = user["${WorkListShort.Railunload}-CMT"]?? 'none',
        MBCReplace = user["${WorkListShort.MBCReplace}-CMT"]?? 'none',
        Lift = user["${WorkListShort.Lift}-CMT"]?? 'none',
        Pack = user["${WorkListShort.Pack}-CMT"]?? 'none',
        Generate = user["${WorkListShort.Generate}-CMT"]?? 'none',
        SEJ = user["${WorkListShort.SEJ}-CMT"]?? 'none',
        RailPrep = user["${WorkListShort.RailPrep}-CMT"]?? 'none',
        LBR = user["${WorkListShort.LBR}-CMT"]?? 'none',
        Payment = user["${WorkListShort.Payment}-CMT"]?? 'none',
        Extra = user["${WorkListShort.Extra}-CMT"]?? 'none';

}

class WorkRoadorLoop{
  String ERC;
  String MBS;
  String RH;
  String Paint;
  String ERCHeat;
  String DressBox;
  String Gas;
  String NewMBC;
  String Crib;
  String TRRprep;
  String TRR;
  String Partner;
  String Drill;
  String Destress;
  String DestressTensor;
  String Railunload;
  String MBCReplace;
  String Lift;
  String Pack;
  String Generate;
  String SEJ;
  String RailPrep;
  String LBR;
  String Payment;
  String Extra;

  WorkRoadorLoop({required this.ERC,
    required this.MBS,
    required this.RH,
    required this.Paint,
    required this.ERCHeat,
    required this.DressBox,
    required this.Gas,
    required this.NewMBC,
    required this.Crib,
    required this.TRRprep,
    required this.TRR,
    required this.Partner,
    required this.Drill,
    required this.Destress,
    required this.DestressTensor,
    required this.Railunload,
    required this.MBCReplace,
    required this.Lift,
    required this.Pack,
    required this.Generate,
    required this.SEJ,
    required this.RailPrep,
    required this.LBR,
    required this.Payment,
    required this.Extra
  });



  WorkRoadorLoop.toJson(Map<String,dynamic> user):

        ERC = user["${WorkListShort.ERC}_Road"] ?? 'none',
        MBS = user["${WorkListShort.MBS}_Road"] ?? 'none',
        RH = user["${WorkListShort.RH}_Road"] ?? 'none',
        Paint = user["${WorkListShort.Paint}_Road"] ?? 'none',
        ERCHeat = user["${WorkListShort.ERCHeat}_Road"] ?? 'none',
        DressBox = user["${WorkListShort.DressBox}_Road"] ?? 'none',
        Gas = user["${WorkListShort.Gas}_Road"] ?? 'none',
        NewMBC = user["${WorkListShort.NewMBC}_Road"] ?? 'none',
        Crib = user["${WorkListShort.Crib}_Road"]?? 'none',
        TRRprep =user["${WorkListShort.TRRprep}_Road"]?? 'none',
        TRR = user["${WorkListShort.TRR}_Road"]?? 'none',
        Partner = user["${WorkListShort.Partner}_Road"]?? 'none',
        Drill = user["${WorkListShort.Drill}_Road"]?? 'none',
        Destress = user["${WorkListShort.Destress}_Road"]?? 'none',
        DestressTensor = user["${WorkListShort.DestressTensor}_Road"]?? 'none',
        Railunload = user["${WorkListShort.Railunload}_Road"]?? 'none',
        MBCReplace = user["${WorkListShort.MBCReplace}_Road"]?? 'none',
        Lift = user["${WorkListShort.Lift}_Road"]?? 'none',
        Pack = user["${WorkListShort.Pack}_Road"]?? 'none',
        Generate = user["${WorkListShort.Generate}_Road"]?? 'none',
        SEJ = user["${WorkListShort.SEJ}_Road"]?? 'none',
        RailPrep = user["${WorkListShort.RailPrep}_Road"]?? 'none',
        LBR = user["${WorkListShort.LBR}_Road"]?? 'none',
        Payment = user["${WorkListShort.Payment}_Road"]?? 'none',
        Extra = user["${WorkListShort.Extra}_Road"]?? 'none';
}

class WorkRepeat{
  int ERC;
  int MBS;
  int RH;
  int Paint;
  int ERCHeat;
  int DressBox;
  int Gas;
  int NewMBC;
  int Crib;
  int TRRprep;
  int TRR;
  int Partner;
  int Drill;
  int Destress;
  int DestressTensor;
  int Railunload;
  int MBCReplace;
  int Lift;
  int Pack;
  int Generate;
  int SEJ;
  int RailPrep;
  int LBR;
  int Payment;
  int Extra;

  WorkRepeat({required this.ERC,
    required this.MBS,
    required this.RH,
    required this.Paint,
    required this.ERCHeat,
    required this.DressBox,
    required this.Gas,
    required this.NewMBC,
    required this.Crib,
    required this.TRRprep,
    required this.TRR,
    required this.Partner,
    required this.Drill,
    required this.Destress,
    required this.DestressTensor,
    required this.Railunload,
    required this.MBCReplace,
    required this.Lift,
    required this.Pack,
    required this.Generate,
    required this.SEJ,
    required this.RailPrep,
    required this.LBR,
    required this.Payment,
    required this.Extra
  });



  WorkRepeat.toJson(Map<String,dynamic> user):

        ERC = user["${WorkListShort.ERC}"] ?? 0 ,
        MBS = user["${WorkListShort.MBS}"] ?? 0,
        RH = user["${WorkListShort.RH}"] ?? 0,
        Paint = user["${WorkListShort.Paint}"]?? 0,
        ERCHeat = user["${WorkListShort.ERCHeat}"]?? 0,
        DressBox = user["${WorkListShort.DressBox}"]?? 0,
        Gas = user["${WorkListShort.Gas}"]?? 0,
        NewMBC = user["${WorkListShort.NewMBC}"]?? 0,
        Crib = user["${WorkListShort.Crib}"]?? 0,
        TRRprep =user["${WorkListShort.TRRprep}"]?? 0,
        TRR = user["${WorkListShort.TRR}"]?? 0,
        Partner = user["${WorkListShort.Partner}"]?? 0,
        Drill = user["${WorkListShort.Drill}"]?? 0,
        Destress = user["${WorkListShort.Destress}"]?? 0,
        DestressTensor = user["${WorkListShort.DestressTensor}"]?? 0,
        Railunload = user["${WorkListShort.Railunload}"]?? 0,
        MBCReplace = user["${WorkListShort.MBCReplace}"]?? 0,
        Lift = user["${WorkListShort.Lift}"]?? 0,
        Pack = user["${WorkListShort.Pack}"]?? 0,
        Generate = user["${WorkListShort.Generate}"]?? 0,
        SEJ = user["${WorkListShort.SEJ}"]?? 0,
        RailPrep = user["${WorkListShort.RailPrep}"]?? 0,
        LBR = user["${WorkListShort.LBR}"]?? 0,
        Payment = user["${WorkListShort.Payment}"]?? 0,
        Extra = user["${WorkListShort.Extra}"]?? 0;
}

// class WorkLoop{
//   String ERC;
//   String MBS;
//   String RH;
//   String Paint;
//   String ERCHeat;
//   String DressBox;
//   String Gas;
//   String NewMBC;
//   String Crib;
//   String TRRprep;
//   String TRR;
//   String Partner;
//   String Drill;
//   String Destress;
//   String DestressTensor;
//   String Railunload;
//   String MBCReplace;
//   String Lift;
//   String Pack;
//   String Generate;
//   String SEJ;
//   String RailPrep;
//   String LBR;
//   String Payment;
//   String Extra;
//
//   WorkLoop({required this.ERC,
//     required this.MBS,
//     required this.RH,
//     required this.Paint,
//     required this.ERCHeat,
//     required this.DressBox,
//     required this.Gas,
//     required this.NewMBC,
//     required this.Crib,
//     required this.TRRprep,
//     required this.TRR,
//     required this.Partner,
//     required this.Drill,
//     required this.Destress,
//     required this.DestressTensor,
//     required this.Railunload,
//     required this.MBCReplace,
//     required this.Lift,
//     required this.Pack,
//     required this.Generate,
//     required this.SEJ,
//     required this.RailPrep,
//     required this.LBR,
//     required this.Payment,
//     required this.Extra
//   });
//
//
//
//   WorkLoop.toJson(Map<String,dynamic> user):
//
//         ERC = user["${WorkListShort.ERC}_Loop"] ?? 'none',
//         MBS = user["${WorkListShort.MBS}_Loop"] ?? 'none',
//         RH = user["${WorkListShort.RH}_Loop"] ?? 'none',
//         Paint = user["${WorkListShort.Paint}_Loop"] ?? 'none',
//         ERCHeat = user["${WorkListShort.ERCHeat}_Loop"] ?? 'none',
//         DressBox = user["${WorkListShort.DressBox}_Loop"] ?? 'none',
//         Gas = user["${WorkListShort.Gas}_Loop"] ?? 'none',
//         NewMBC = user["${WorkListShort.NewMBC}_Loop"] ?? 'none',
//         Crib = user["${WorkListShort.Crib}_Loop"]?? 'none',
//         TRRprep =user["${WorkListShort.TRRprep}_Loop"]?? 'none',
//         TRR = user["${WorkListShort.TRR}_Loop"]?? 'none',
//         Partner = user["${WorkListShort.Partner}_Loop"]?? 'none',
//         Drill = user["${WorkListShort.Drill}_Loop"]?? 'none',
//         Destress = user["${WorkListShort.Destress}_Loop"]?? 'none',
//         DestressTensor = user["${WorkListShort.DestressTensor}_Loop"]?? 'none',
//         Railunload = user["${WorkListShort.Railunload}_Loop"]?? 'none',
//         MBCReplace = user["${WorkListShort.MBCReplace}_Loop"]?? 'none',
//         Lift = user["${WorkListShort.Lift}_Loop"]?? 'none',
//         Pack = user["${WorkListShort.Pack}_Loop"]?? 'none',
//         Generate = user["${WorkListShort.Generate}_Loop"]?? 'none',
//         SEJ = user["${WorkListShort.SEJ}_Loop"]?? 'none',
//         RailPrep = user["${WorkListShort.RailPrep}_Loop"]?? 'none',
//         LBR = user["${WorkListShort.LBR}_Loop"]?? 'none',
//         Payment = user["${WorkListShort.Payment}_Loop"]?? 'none',
//         Extra = user["${WorkListShort.Extra}_Loop"]?? 'none';
// }