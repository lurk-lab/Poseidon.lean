import Poseidon.Hash
import Poseidon.Profile
import YatimaStdLib.Matrix
import YatimaStdLib.Zmod

namespace Poseidon

def SecLurk3 : SecProfile := {
  M := 128
  t := 4
  p := 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001
  a := 5
}

def Lurk3.Profile : HashProfile := {
  SecLurk3 with
  fullRounds := 8
  partRounds := 56
}
namespace Lurk3

def MDS : Array $ Array (Zmod Lurk3.Profile.p) := 
#[#[0x56f23d7e5f361df6266b620607396203fece3b023ffec4ff3fffffff40000001,
    0x458e97984c2b4b2b51ef819e6c2de803323e959b66656a65cccccccc33333334,
    0x609b60c54d5893118005895c0806deaf1b1e08ad2aa94ca9d555555480000001,
    0x211f5460e751918257c7624b7077624aaa362edc49241a48db6db6db24924925],
  #[0x458e97984c2b4b2b51ef819e6c2de803323e959b66656a65cccccccc33333334,
    0x609b60c54d5893118005895c0806deaf1b1e08ad2aa94ca9d555555480000001,
    0x211f5460e751918257c7624b7077624aaa362edc49241a48db6db6db24924925,
    0x656ff268c469cd9f2cd29d07086d9d04a945ef829ffe907f1fffffff20000001],
  #[0x609b60c54d5893118005895c0806deaf1b1e08ad2aa94ca9d555555480000001,
    0x211f5460e751918257c7624b7077624aaa362edc49241a48db6db6db24924925,
    0x656ff268c469cd9f2cd29d07086d9d04a945ef829ffe907f1fffffff20000001,
    0x19c308bd25b13848eef068e557794c72f62a247271c6bf1c38e38e38aaaaaaab],
  #[0x211f5460e751918257c7624b7077624aaa362edc49241a48db6db6db24924925,
    0x656ff268c469cd9f2cd29d07086d9d04a945ef829ffe907f1fffffff20000001,
    0x19c308bd25b13848eef068e557794c72f62a247271c6bf1c38e38e38aaaaaaab,
    0x22c74bcc2615a595a8f7c0cf3616f401991f4acdb332b532e66666661999999a]]

def roundConstants : Array (Zmod Lurk3.Profile.p):= 
#[0x435dbb70fe9639bb3d2e7e1948b167bbcc7c29bed7d24e2ae783b7258c3b9b79,
  0x307afe4a167ba0d1d93f60f15346bda015fa08615bc785bd204aee1741264d5,
  0x5c0e30ebca2f181197c0f06e98379ea11ca0b657bf1dde1060041f9e959945d2,
  0x181b9f96bd7efa33178ba5316e4441a392c2bb1e0d5437a8ff1613f5997cc4cf,
  0x428c5fb2bb090a1139904e862c27c1de0beb6790719c72495e4b83053dcdc51e,
  0x6966e075558905b9ce6122ae7c5bd2cdd5dc93f394ce03b64e2a6a6267b81206,
  0x521a2ac09efda0859ac79dc6b7948ed9d184b70a93397757c7e1e78cb95e2ce6,
  0xe09bd2528ba0b94d6ed86121aa48abf769d47c65138c5993a573528d2f09837,
  0x1360abae0b804b8f70007cc8953ee7697a650fba556e3f0bdacb8376f4ad5519,
  0x616b4bfdf7c135daf2dda0fc23649e67ecadd04666c0c20b25abcaf4325dea5,
  0x30d52aeb1848a121c102f3cd4c26c3a8b33a012d9a5d5d370ec2469d6bb621be,
  0x29179ed83ab1110b93767b25101a0ed78388651d7926f80d0bedaee66e4dfc37,
  0x71e1b7a0d4251e03b897b26d64e19230a94d5579de0114e99172feacaa50f1c,
  0x8c69e6eddea48915949a0c7aa08d1d01b5128f7eb998d97b870d9f51f1aecdc,
  0xec55a6b06550b25d3df32a9c2e24ae00a89b1a19d65226986033c2bbad66e02,
  0x38891749192cdac572a4eb14bdef515ebcfa720fd7170230bacfbb62862401cc,
  0x210e13978dc5983b3efc3c3643b0df191cb26f2eb0085079578b1498f6c6f19a,
  0xe7df63365732c5484104c7db6676a77ce32e0a4a06f78a54d70e5fd655adbc0,
  0x2378638e5e2c069daf8135babf89ce5f62d5fd5f374bc6a85d5d8e835df9a8c3,
  0x429b476c33c844ffc774fdb4573a05fcf60f6c62f881b21dc2bedd7ce3d699d9,
  0xc1776202f964b1050a843ec1c09d0b2737a3562b0ac9a35d4d341a36fee7b5e,
  0x214769f3449c3ec3a1d274c932b9b20b7d58606f1b39ec4d7c550f90f4980d7e,
  0x2440ca310753171d1ecb3276fcb1abe78329665f1ee54031f62f02238467fe6e,
  0x41d7fc31fb80088dd2e5050e9ca265bf0d3367272b97abe417e3889ec3edc8f6,
  0x6acceda1e5b88a6d5e62c93a248225b3d019f22564f7b5dc2aacf619ae2f8647,
  0x3bd0c24df838361cf463d5346262b4a83fbdeda25ead4bdf3a0ec683247546a2,
  0x1c46861bb307c05ef9744ab2f3f1121944e4c45034ee6ac8f0272e755d4b6f6d,
  0xaff9e92f3b43678fe551bbd8f25c2613b03c0b8246079e180a6cd2cbb4c9c24,
  0x65c86e5cf041918dd50f1459eae4988cdd99a4bf7d1babfd946ffa235de2e73c,
  0x34456093491393fc5ae59ab7c7b6169c0b0939a52e085f495559c23a7c7e6c14,
  0x39135f352442c5fa32c3400534c994e279913fabfcd9373bca18052fcef15803,
  0x6354a55ec8726101d11a749214be3c6418b1816e577e08f1c1a2f435614896cb,
  0xd3b0448c50b68f7baceaccd94552a122b89b786ca620b863c02a7a5bfe774cd,
  0x37de17de5d77d1aa293a04e1d2a9ccf8f5f475f1f6d00b2a9e279e20b6df70c3,
  0x3f06cd79850df6108be46661a92292eee0981c98d05ec2f553b8e7a6cdd15a13,
  0x1190dda4cbcc050860d69d9b0841f371e6ee0f1f3e318a193a3d254c8ea19930,
  0x4d486da7382a041ff02f0d19ac57a8d10a46363a3ff70fe6166ecc52d073902d,
  0x2b6542eaeb87fc42fcd92147064a91a0214004b6d838afd7346a2716b3ef92cf,
  0x57511ad2e251bb9c3510331ef75a449de6ab76044785522e2c58118073734374,
  0x3d8b02b647073d6bb96f2e9b27b0fb80748c9fda99003c8529460644a3999544,
  0x4d01c4c679e545449955e318ee0d32c66969b9ef7351cbefcff2be6db93d6340,
  0xd148334ee5f03afe680a0bfbc479ebba90c149c251c38dc7214d192adc23d59,
  0x51cb09abe4ca48849b8ed609a35530063d1e108bef461b57cb4ab256d23c8715,
  0x6cb836cc464e1def59ee2eb012ece332dbe6e8d40fe5be20d467f1aac6463a64,
  0x4aa865b463081e81767d3a0bb6d996b80b46e60d252d4acdc6a58b686981a4e1,
  0x6d74e3ccfee94f471b8e2906f26117fa6ae0a5ecbeb8d5d6be7670950c7ad08e,
  0x31de4d8889e45640c1ab6cb3c1e448a59251868082c8661e23ca2494fe20db41,
  0xcb45744245e16f06ceaa2fb2a7a867250aeb0b72c1362dbd59e8c42fc272403,
  0x2022672836eb3a87b07d2b8e8d3d54e84ef074c3f3711f812ff4b917f724c9bd,
  0x14a3a3c5e0772147a6099b58ddea285408e653738c665389206678f49cde7ed0,
  0x64aaf5f888bb77306894f4197dd84f69ee9def0215594abdce5ea7981fd7b04a,
  0x5966360244e5804391c0a967aa24682ed0d253169803f1de4d7a74610ad696fd,
  0x72ab5d880b24076b9ab2bde88b7f6c33b0f7dbebacc7fbcb34b7a8257a7d96d7,
  0x6710e136713dc87ff3f9cb210aa1db11394f00ce3b255a9c7c717edb53a62107,
  0xb4a708d71ca90ea133e0532a3328c3957ce53f2b9e3fc6d17271d47d9d35b67,
  0x4c2375cffbedf2ecde0634f867383938a70cec4f409f728859244d9df7d15154,
  0x604027adcb15669476ccba80d2d5c279f7284cadcfca2e5fea7a3dbf25a07ff9,
  0x4b3f8fdba7c3c15a60e060fb40c89ac3774a5d05563fbabd283049c681dc3e88,
  0x3e4ef282d1a982e9d194441da324ad190ebc272c35f87da4b493731d145ed9e3,
  0x3ca36c11fab63fbde4d2b6acd740791e802ebe6888ff85be9be64a34afdb96e0,
  0x59b6ac07a1c1e77c48969c3ff79699ce5c341a4dd7716bab3711caefd1e08983,
  0x585c41ab8870f47026fcb4920d5a1dfc46afd9193f71f2d6abe9e13f4a37c00,
  0x3306f364dce1e440ad2351d33fbe5f15fbdf4d9ff17d27e8b21d14f00e95320a,
  0x30a82fe3a10afe039f3e8c2e7546ff76a4a3d4541b58125dbdb0d2516fe8a6ec,
  0x688ffb1af4d60ba856a3b19eb147ce65cd68ace786afda1bfc574c9b93250f6e,
  0x1ce1b8d7866ead6b29cdce992ab8960686cf3a6bc7feb49c3d460abbcb069c0e,
  0x2cbff76a00d623515166d5b581f0adc4f7f713eabfc757e853f667893c90a827,
  0x63a260c6e46d75512b405b32c6ec7f8acdd64dd6d53eae4e2e395cdd9f5c520d,
  0x42223d517e729c29cd0043929a48b7e3ad9251375c3a869ff7ac95aa98445a0b,
  0x4db292dea742799cf5ec29f166d16703d01f66e48c0d2566dff402af4a680a32,
  0x61740f9a82c6a4fa9abc516991f0e6b87f0d5a319bb8256026f184513919dffe,
  0x66c2eaa8ca804300d86a3972bddb6a53817d1c36af548c7362f79da78aa6816b,
  0x1519e66cc576cc14ce2956470e8cdb70420740ecabfa6181c7176a70e79af414,
  0x6ebf120fa7c372ce9c7c17a07bdda63e9ea3b2eeb5f4a7bac8d908e7f1209103,
  0x5395c9ae6af6ee4858f9344f430ee8208843fde1cf235f97b60bdc5a3e848995,
  0x1fa295097c1d41e6fbd9f72fb0af9b5aa3d1a8196821b0305527bf62979b97b0,
  0x42ddc7f384cf8f928cde8f88f4ee7d7b62b9163ac70aca740f2bf7e52e38228c,
  0x54811c99d6c88a6277fa41dafe17b7a4f2b8ac8582fe266c751fdf7d2a88fd40,
  0x3ccbabd0849789cc1c434dd0c7356a0ec71d03db3ab227aec51f2a5abbd8aacb,
  0x40d6918f0d6d75cae13b6cc63e771b27ee189301d97a2a207019f1646dfbf810,
  0x25a0fac67dce64b86695c1f9986dfd547f51b603f6d73b5c849c9548547e2b32,
  0x2307d40b97903f0f59f5df01de9ac9a823edc818619d555ec3d9882bf5ad2fca,
  0x398549f8aad34cb56e6f66bc76f30b7e0a0379292e0c9db49ef928719e83c4ae,
  0x562b6d5e4cae80684baf14b45f5216ac45e8dd10ff8d99531a94332966a7d8d6,
  0xde2f7224c7db546a7aa0b7097c6d48846cbe5ab35adbdbc14a134581a399168,
  0x6645f7389026a44284598c2ad679a73a487db8ce965577e57f51361acb684c1b,
  0x47987c690cb45bd23189fe76ae6fe562ca7757ebbd5f861e97c6493f20e3058c,
  0x6c158b77a9457918cf699d0759b2588e8c3e2083645e4acbc679ffe60b4ed081,
  0x3a8f448b6dfdbab048b5f193acd1d89b3c0d8777449a7c9e82836d71fce09cb,
  0x6f82e6cb42fa93680f1058179be9ff2463a16bc2af5cfe85bba7b6f78b057b6f,
  0x6fdc6c0c05fba5fc05e81673a730002393e23f5d6ac931dcae63255550b941a2,
  0x18fd1168c293c5075de568971d285277010e8cc19dc1bf17b2dae0a3a38a0bda,
  0x61f681ade3a5eb4308a786c967a76ad142ea814f5fcd788cd326a18d861855ef,
  0x46351a8e970814672c6c2a5b8a2c4bf93291d4a7086b321e5d774a214f6cee42,
  0x2b48e2821ea22551541577ada2edc1066077c766c1c0a84abeed33b2862624c6,
  0x3af5569027cd396d262908fbcaedc7aaebd9ce44995833b312607ad33cfc958,
  0x6771e0cbfcd5854b869555fa79c9b46f0704f1ceddb2003538864ac645887231,
  0xc60fc4ac4bab581a11fea9b1b5e1e1e4692e78231faedc6719ada9a395e5c84,
  0x553b99c71556f4d8ed95945a96d6cc1bf70a0d2307f77d5e6ddcffe852278d5,
  0x14b6aea2c0ba14365b3a0c56e937338bb8555c415400e287f8b7bbe67b59b971,
  0x5b82bbc5b5c301000e0ce4a34777f6df59ab8540338a32d1eb50426c9bb95309,
  0x35f07a3ebc8947fcc9a72c3838bdf80000c0caa346aff7d1fa45ddf3b5892df9,
  0x158c739d41772ef413fb5b7b21fcf0e8bfb9fbf9a4318f99d5467d05ece81587,
  0x2f7ebdafde0bbe158a265dee8b18a1a4a0151952d06d15f389b2e517292b96eb,
  0x41da27c7cb76adb43dc3e4d1afc732aace59618f0e2eb0923372f66504ca3076,
  0xa80d961878f34b45b371a87b2ebb1f9b58f3fd2719e5376d802c238796b11e9,
  0x6d3885078660fac763b5982bd1f401043b5ca158341d24aff76b84b1df818290,
  0x12cec3917acb30cc1e15281aa7bf53d90419d216986623613fb10aca9be742f7,
  0x58289c672e594998792c12773554138fe3292caace0bfbadf01cee48ab72240a,
  0x31c1bcad4eef1a0d7a73bfc7291951c337860dd5730ffb7400bc9ec72a76de9e,
  0x1a28349b10c85633174b26436ec2cbc372ed1afd4b29af83cc89cb94ef457891,
  0x5d6e8ad13be5518ec892ed1520c066a64ae425bd392c77b8843b8e842512fbe0,
  0xa2a6963b53495afbd3d312c684c5babc0037651d8f180d35d66aef892b9d2b,
  0x5572d3d64b5bc3a507568493f71cf86208611fc997e323d8e92bf909b07afe89,
  0x2f4d74cea3c17f17d4778ce57e59bc217f8a5856d189079f0b60a681c0e325f3,
  0x6689968d8d529724311b6fe789bde980cb92392a91182edc36c57b09f4405304,
  0x4d51b3403c6ddcec7ac976e62754c65bc338d5ea651555a876285dfc24702141,
  0x6349b82e8184a0f1da93e07a6901fc23cf25bed7d6bedf709249947ee7ed5a35,
  0x18a791400b6eefa2b19c6f83e019f170aa6bd445fcf4915f915b621c1573ba44,
  0x333d6751bc4ab5d168a2ae3c6ceb237e26ae948bfb205e8b060d383cdd674fe3,
  0x374d51e4dee080abb1a2cc25a988ee15320ce11fad84e8eecfe3cf5bae13863f,
  0x2b42981ce6690c373ff43ed24e5c784ff2e192d0911ccffdc8262dc532de4867,
  0x4a8002ec5feb1b6bafb30fb78d65023254751977478d7af2c7fa0e87b83d926,
  0x2f82302976ba29681c7cbcf49d0ad1e1609c1e727e2a40cf30260d3ce57dd6c3,
  0x2bf08176879b9da45776d2fd57988de0f12f33ce757411f27dbaa181f9cd9a6b,
  0x39851bff4e488eecb8e1f59168682fa47c2d057aaefec12315e2dfcf7df5ee0,
  0x605a4bdeadac0722061fbb098c05f47ccdc26ebdb45bda575f0c9495d27f6de4,
  0x609c5a5b62e3eb56edbe6dcf30f937502434ff935f5564c0a5d0f686b8c4583a,
  0x4d041c087422144212ec8978bcccbf1b8f471799bb8fb5c527f7bf4902fdee49,
  0x17e6b7fa91ce16fa1818c61b4871acbbed0e3dd902aae03afaedb7a14c65132f,
  0x528644c51eee10eb8373d43a3980b12df839fa178de5791f4cc53fc7cfae9614,
  0x60616ade433fdfe048b713947f8b8475954331d393be923e772ef97ba70ebe31,
  0x668f41b34ea071e41aad40bc6b04e5102eb2a15500d515c0d6e7013677005d0b,
  0x143b1f278815a0285a453ac96e232fd54dc965b7af415a474cbf204a6f4c2654,
  0x493726bef63266b200039437e47ee655704f641c785c72de2a7f852653b2aa9f,
  0x13dc1ab1544f728cccb110b5d8a3b47b3331e57cfa9882786adb86cc70e55e73,
  0x6fdb4a1b633c3e8b52910d143bc78493505fc721a469ebae764aa9d5f2fbd2e3,
  0x10c11599636ea832ab3aca48b1a46c1b9a97dd0d5df68cfe2e6ebb2a0d5c1b2d,
  0x3d333054b81e7f1a488baaf2972d6b41cd228e7e2fc44bd0dcadde4c50520882,
  0x416549b06324046bdc8ea26e337a0a6ddeb83bb76e85ed609f4ffcfee9556fdf,
  0x4fc2c645eb8ef43ac68aaef6992cbb7ef2215af392f7cf0bb326efe04b029c3b,
  0x3615cdc9e839c98533ce09ec9139c9fb703d65bee903667cdfbeaa374032becf,
  0x3723d731de7ebc74575fbe5701cd94ba51dbdd04a37afdbfb917e8f75d52b9ef,
  0x4a061269abad785b7d1e3910c2ce47baa807df2be6b8f5154a823c225ba575c8,
  0x83a8a784a984f22564334b099cc5db6297ea2831f6c98b92222b48b221fa872,
  0x618235c3469a8443bf0c02a5113d258ffa6397c348b5e96369a4ad47781e4f7f,
  0x20a22918f833d921243c3d40791e5532bb96632e4c1e6fd65b4a6edb9d12d1a9,
  0x15f31ec89c9f83b4681857307fc8b97a4ece66c5049e73000dcb3117c570648e,
  0x1458e387ac0fea846f84590101b081bf90185387542d5cc0c097f440d51ec533,
  0x3bd2626d79f9b1d5689ceadd8e91ff146972b91bf85006efefd2b01e497ac3bc,
  0x1d6a3cb53bc3be5050418257b01d9d5d0b1022538d8d5426cf2ad130a84bda92,
  0x408f60ba780bf6331f410c132919f21a91dffb689c2dfd1c8a1e74a202f41f49,
  0x6ba975d7b853cc0321a7a236d8cf0dfdb056588ddeaf82f9b82778f6d0a78ede,
  0x18a3b273d1e8715a336b3f412a928b81bff10be01094711965c6375a3fbc0730,
  0x36fc46cd7f322b010550bc1036f1c7abec5aec8e1a5cf6ef77d7913b662a9704,
  0x3418d0dfcab4f80176020091b5a8a8f98e8803122929e5cc9ff632fdb40d8b1a,
  0xd910826913820c68af0552f51222e023bef305453ffc848d52796855b43b5f1,
  0x636f59eeb8428abed226c38296e39524fff76afb1525959108c0efaf049a47b8,
  0x6d5f15e9c5bddcfd6f6f86b9a078f227bcf841a7d908786f5abcee128827233,
  0x6e21dbe0b1ca7c453fc8629f3f0ad4e9d01aed47f6cc9d5ed8166c6b00367d22,
  0x9d9434f8dc085dfc74a3d15f73d89a1bde46f2c79659015e87a86d4f61e451c,
  0x4ffbf816fd76132cc64d02bf952c538b5fb3adc51a31421e718e8f8aaebb8b2f,
  0x7061bca7b176fc8893957c8ad8bda36d884c4104895c815cd8e78f49f90e4630,
  0x21ddfccc092128048874a0c53156c08f9504a21d94dfc3ebda4d13073363c89a,
  0x25e8ae5cc161160ea672beebb4ab2746950cd878072e1264df907ae9eb8fbace,
  0x121c45420abf8e5cdab3ec9632c1becb3c42fe32aea83fa5265855d4ce4b51ad,
  0x14a00fbc9c1a0319a19fe7dab909e800433556a4d394d50810dd9e42f79cd019,
  0x7261bcd2cab92a568d0f0f6d063161d3988579c3d37618775243eff31aa2e748,
  0x108a5bb864bef87c1ebcc6dfbe909eb7a792e180fcaa4fb60ce02a48e3f0b03e,
  0x34d973e68a2b1179db3fe9937c5454b3adf89e495219ea8df5faaeaa67d30415,
  0x1cc5702ef8cb0d489d447d08f7b66d22deed85b2e9e891317717fb1a8e8ac826,
  0x1276800cddffa60515a5e57cc2cddcc3419cf1eed8791474c2188ee27eef0a28,
  0x26a5bb35746471b63ef933bca24a49d366a58ca54150f0e524592795e1f4f695,
  0x25c0a52e174ddcc11b5a3713702824a0608baabe32b55d293b201a0a27c2964d,
  0x2b8cda9580ce03aabcd2508cce9bdbdf5b48fa7563c89dbd2db16cba4575e3b0,
  0x48f8b225f65fa4f33d31e10698af06c59e387647d421d2005437d3a2a250ca2d,
  0x112f07705f98748cc06f8ffd03e31f467d969fd05884db149a21e48537b6b0ef,
  0x1a4923cd0a20ff2e2c0c3b89fc6069408e6b594b73061b26d781035a1c3d0872,
  0x83130d75669dc95c0ca482e1a10caaf51863cf55af33ac10520e63cc8fc27ad,
  0x492227265ac1e9f4b7679ee9975ce8d0b1adb3f9bd0b009c0a740b1de8de057d,
  0x56c011941817140f9d524e7bab7c6ba0141bb007ec3699f8b998ce206816fc78,
  0x34033f30606670727f5aedfff6be8d2013f3694b614965ed91cac1d8081187ad,
  0x1ee164f8a35c64a2c356cc7db807cd83778914344b3549941090bda2c4ba39b,
  0x42bb3cf5995d0f35e0214d8c0de0f569ab41e9ef75e71d0674012892d68ac68c,
  0x283963400a7600040fe3e0fef299baad9b753a3a95132383e941453fe608cf69,
  0x5645c81a6c057a50c7f415d774883607953b3865578cd9ba28101724b1751d05,
  0x380a6b4359b921620795b3da872d508b935b811cb6d02c805667ffcb28af4d24,
  0x2bad04565d6cc61669143b6ece9a1a77093ddd963c55e3a3cc11c53844041ea6,
  0xcf4a15499ae28bad732654915dc1d5b67a511845737909b1cccf50680f5ba31,
  0x17c34ab6a23a149f249d490c9e88afc957ede5efbc18eb787890f63327e628e1,
  0x38383a5e3b0fbf5350d048c4f16997705e8b9aa0e64da87252a3b21979e11ac5,
  0x44f69eb8e9f7e53ea84bfe91293ab3a65f1fe6ab8bf7494e026afac6ac2bf484,
  0x69a6655b628cb6e9c6e3b3b94f1ea8a2641c17a561e4a37eccbde34972624e3c,
  0xe072d0b971d68d536b76352ed16c6dab0440eca585cab64a4e0ba1e08615410,
  0x4733e876b3b3f74ba58cf56b64faf89a95f1e7052599606c84b0b50e476ba880,
  0x6d802356b1b924cee10d0bf2f0b480b54306b994218dcb9225e5400eb81b65ef,
  0x60865619d73e9c6425faae1db8f9f3a491401b32b578fed491191d4dfaf2f3ac,
  0xb04d062c0757ef7ba7f8e54af428969c013d257e1f3d41d0dbbd0bad7711723,
  0x22ac7eecc33347bc1c2abd26c1a9b35853bce937c75c542932aa1e87141f3ce0,
  0x3ae3a7684111702cbeb86ceb67667cb3abc3afa2c93f0d8d8f2805fdf42c7594,
  0x3e6b658310803f709adf8954c9b3b02864b37a490a84597bf74d380c06d0287e,
  0x273dc3b92d063f1d67c3e4d61e7bf0dc505f84aafa1243e9ebd12120317abf1,
  0x1475088d8c356e610e5f4763d203c62e5bb941bf73a1716c43af9f1d50509f96,
  0x1386d879763a44d259f99582124ef6d7302d3da8fd135fc4d8304117bc067fe3,
  0x1daa41aa1644ebb8216172bcd30fb28e4e13ae754bd5bb08245fd3e39434e687,
  0x124218390fad40862326265e6de2a7651ec5c5a6d422e568952b8fbee667caff,
  0x1504f873a252e20b48d74663014532b2eff87628ab2955c97d0c48892c90b9cf,
  0x1110bb10c565de009979db75bbe47c466d4cf37b822113f2ce77453e0a87f621,
  0x316437b96f9cc8c18cd320e919e0d024fa4a4c487f7d78a2ad03e35df9b24d49,
  0x70b15b8c41cb5fe087542b0abb05767d41fe184e67b489f4f0483265c45ae8d6,
  0x24699333c2f08060595bea2f67d5c69e016d4dcd6399e9d1dbb6e69de7bc82d8,
  0x5f6868c658998b59347d630ff37f438b8ac1cee1156c87a34972c6632d770f22,
  0x328922bcbaa152406015cae1a2a1ca9b15519c6cd36588d5f51856182fd5a232,
  0x5f1e4cff7c62b3a5bc89ba6fc70e7d20e61502f0b57ee51442b4d40da806b1e0,
  0x59b1e88b79a00ed114839aebfd02b95dc11c61e02d871ff73c0ea986b95b409b,
  0x4544ccfe8fb21d6a49db579aaa2d23939b6afd73bc8bfaccb9f8e13052638f9a,
  0x47a0138447359ad695a898bb9f8f3d7770e74d3d1a382ae786af997d281c20d1,
  0x3e385dcf88eca0c3c48bb0efb87d79b7f8da55e4c511f178af6b2d1fac2e12a3,
  0x183b5d3b2d59067eab3a4422c7377c8e3f2e752eb9b22c97a8b7389e4fd01113,
  0x37562ce51991499f8ad4cfe18ccd472052bda02c9ee4dbdfe3463dae34445d75,
  0x421b21857527aa12f79a0d1e1712b31ee3c12f4f82c2e87954cee5bad9899d00,
  0x34446ddd54ad408830dac6f68080e4b7d3999eb1cf32484e47cb58dcb4efca49,
  0x52f2e208640f3d96cce87b89d5a1f1e100340ee6b59740b613c736e1dbbb7f5,
  0x3d4fe52bc2ea3d112fbdabd937c13094cfb2d2914fbb21f6b417c5e08db84af7,
  0x23957ffc11794cafe82485702c3e550f9c4254ea1c170acb5f297ada1d6160dd,
  0x74918240e1ea0c22f1cb2ab87f019c60c93f97b3bac35766ad9675a9b698880,
  0x72a6cb8d1ab3e1c262e67b7383af5989833135965ef0939d3ef5b9a772cb2075,
  0x6ed13064351b11a6edb5fad36c09dd2c8ca35a81bed8429699813f0f52c676,
  0x14b9a2ca056d4af215d7c4e767a773934bb878263244cdf2fe3d91a923037824,
  0x17b7b4546ab94959ae33fef218a61010cee1bef29fefc4bec925b29004c931e8,
  0x127647ad48ff4c00766303f7f11ab9e50d3e454a12fdf6e1f0a65d3ffcfed25d,
  0x156e8df1f40957f9cddb9109a36990e6435f8f3192475a0421a24b50831169ee,
  0x14a93d5ec7b96474fcbb753a9705225989e7222185d3ba3ea98425288f61f947,
  0x342428fa567003be2117f74f6e2b64f92d1852b3a19785c85a9dcdc6414739a3,
  0x69728785a386d98f1415897eef703c1fd12ea0ebbb08d1a4b86ca4a876970e05,
  0x4205dbfd44798d218413a9ad69d1bba8c2171fe686f8d5e5161ef70e470a2dc8,
  0x110e7c6c09c770034a4a3159af1552b93b6a5dcca36d4fe17c4d1ad25ef98a60,
  0x2995c20c83bb958c655d9d7331ce04fdefbe3795bb41af31346836db93857aa5,
  0x2f638c37f8c9b2fd506acc1a6716cbc2e035e6e3c6b7a18bd656bfab5f44bb7a,
  0x9163acefb6a19112feb57a0d5dfa40ec9be98bc7393fa651447c2a08b2e92b9,
  0xa14e2951283469d27d64ff53de85bfec39491c9cc17d7867d34f4ac2c7ed1,
  0x17cfd1f18d6a19c63f3eba4742556382118ab17655e3dc2a2db314448afb563d,
  0x4329d7e65590b914a826cd44e44e9bf40bcb7795dbc9967cdf22f7c235e54944,
  0x27ae8b032c813b4068cf9ed7a33e4412c2c2a542c0b852c223488e1835e090f2,
  0x71d2902bb26a43c8a22c8e1b0e2c90c0b9e6855ebac5d2759842fea1576d85a,
  0x5f85259bbd72609259df9d1eab84634decdd42bca99a7915b1ce0d2d13bc72fe,
  0x2694ef88035366770006ac71a69237683c9338cc3170d8ba53af6abcffc0e029,
  0x5b9711d919c871e2856571ed2de34f76bcebf1f6338b3149465f1b266fd36c9d,
  0x16880111cfebe378ce8f8a9f7ed97a8579533bac735afc9e40c06f5495409075,
  0x4d836438f0db187658eed75bae31ce7d978a1932aa894665235fee6e49b77abe,
  0x2c03d6f3484ca56c256ba91a1d71a4210d840f07749196ff752c491c79e427f8,
  0x350594d4c210d6e66ef4fcbda72c80cd55b3dee5e91250a63d4cad3b14b77478,
  0x5d50f9c8ff9b251d03b712c6f8d60f6137d192e69be0a92380a64d310a084e02,
  0x1375498a707afe69452fc093e90d23a54563582fa18813f02bfe996d35569f02,
  0x23e23d46ea3bc5cfb9aff1642e998710880b414a2048193b5dc642001a9fe1aa,
  0x9dbae187a8543426c478b15560ca1838400236b1bf598dbdb1878b35eefe09e]

  end Lurk3