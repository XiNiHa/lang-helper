type t = {
  imageSrc: string,
  audioSrc: string
}

let words = [
  {
    audioSrc: `001된장찌개.mp3`,
    imageSrc: `001된장찌개.jpeg`
  },
  {
    audioSrc: `002두부.mp3`,
    imageSrc: `002두부.jpeg`
  },
  {
    audioSrc: `003김치.mp3`,
    imageSrc: `003김치.jpg`
  },
  {
    audioSrc: `004시금치.mp3`,
    imageSrc: `004시금치.jpg`
  },
  {
    audioSrc: `005애호박.mp3`,
    imageSrc: `005애호박.jpg`
  },
  {
    audioSrc: `006계란.mp3`,
    imageSrc: `006계란.jpg`
  },
  {
    audioSrc: `007스팸.mp3`,
    imageSrc: `007스팸.png`
  },
  {
    audioSrc: `008청국장.mp3`,
    imageSrc: `008청국장.jpg`
  },
  {
    audioSrc: `009돼지껍데기.mp3`,
    imageSrc: `009돼지껍데기.jpg`
  },
  {
    audioSrc: `010삼겹살.mp3`,
    imageSrc: `010삼겹살.jpg`
  },
  {
    audioSrc: `011소고기.mp3`,
    imageSrc: `011소고기.jpg`
  },
  {
    audioSrc: `012승무원.mp3`,
    imageSrc: `012승무원.jpeg`
  },
  {
    audioSrc: `013도시락.mp3`,
    imageSrc: `013도시락.jpg`
  },
  {
    audioSrc: `014마늘.mp3`,
    imageSrc: `014마늘.jpg`
  },
  {
    audioSrc: `015쥐포.mp3`,
    imageSrc: `015쥐포.png`
  },
  {
    audioSrc: `016문어.mp3`,
    imageSrc: `016문어.jpg`
  },
  {
    audioSrc: `017오징어.mp3`,
    imageSrc: `017오징어.jpg`
  },
  {
    audioSrc: `018낙지.mp3`,
    imageSrc: `018낙지.jpg`
  },
  {
    audioSrc: `019카레.mp3`,
    imageSrc: `019카레.jpg`
  },
  {
    audioSrc: `020짜장밥.mp3`,
    imageSrc: `020짜장밥.jpeg`
  },
  {
    audioSrc: `021아이스크림.mp3`,
    imageSrc: `021아이스크림.png`
  },
  {
    audioSrc: `022봄.mp3`,
    imageSrc: `022봄.jpg`
  },
  {
    audioSrc: `023타이어.mp3`,
    imageSrc: `023타이어.jpg`
  },
  {
    audioSrc: `024콜라.mp3`,
    imageSrc: `024콜라.jpeg`
  },
  {
    audioSrc: `025햄버거.mp3`,
    imageSrc: `025햄버거.jpg`
  },
  {
    audioSrc: `026빨대.mp3`,
    imageSrc: `026빨대.jpg`
  },
  {
    audioSrc: `027사우나.mp3`,
    imageSrc: `027사우나.jpg`
  },
  {
    audioSrc: `028목욕탕.mp3`,
    imageSrc: `028목욕탕.jpg`
  },
  {
    audioSrc: `029때수건.mp3`,
    imageSrc: `029때수건.jpg`
  },
  {
    audioSrc: `030면도기.mp3`,
    imageSrc: `030면도기.jpg`
  },
  {
    audioSrc: `031케이크.mp3`,
    imageSrc: `031케이크.jpeg`
  },
  {
    audioSrc: `032우유.mp3`,
    imageSrc: `032우유.jpeg`
  },
  {
    audioSrc: `033막걸리.mp3`,
    imageSrc: `033막걸리.jpeg`
  },
  {
    audioSrc: `034운전.mp3`,
    imageSrc: `034운전.jpeg`
  },
  {
    audioSrc: `035고추가루.mp3`,
    imageSrc: `035고추가루.jpg`
  },
  {
    audioSrc: `036파인애플.mp3`,
    imageSrc: `036파인애플.jpeg`
  },
  {
    audioSrc: `037자두.mp3`,
    imageSrc: `037자두.jpg`
  },
  {
    audioSrc: `038떡볶이.mp3`,
    imageSrc: `038떡볶이.jpg`
  },
  {
    audioSrc: `039순두부찌개.mp3`,
    imageSrc: `039순두부찌개.jpg`
  },
  {
    audioSrc: `040피자.mp3`,
    imageSrc: `040피자.jpg`
  },
  {
    audioSrc: `041김치찌개.mp3`,
    imageSrc: `041김치찌개.jpg`
  },
  {
    audioSrc: `042부대찌개.mp3`,
    imageSrc: `042부대찌개.jpg`
  },
  {
    audioSrc: `043삼계탕.mp3`,
    imageSrc: `043삼계탕.png`
  },
  {
    audioSrc: `044총각김치.mp3`,
    imageSrc: `044총각김치.jpg`
  },
  {
    audioSrc: `045계란후라이.mp3`,
    imageSrc: `045계란후라이.jpg`
  },
  {
    audioSrc: `046멸치볶음.mp3`,
    imageSrc: `046멸치볶음.jpg`
  },
  {
    audioSrc: `047꽈리고추.mp3`,
    imageSrc: `047꽈리고추.jpeg`
  },
  {
    audioSrc: `048김치전.mp3`,
    imageSrc: `048김치전.jpg`
  },
  {
    audioSrc: `049불고기.mp3`,
    imageSrc: `049불고기.jpg`
  },
  {
    audioSrc: `050스파게티.mp3`,
    imageSrc: `050스파게티.jpg`
  },
  {
    audioSrc: `051고등어.mp3`,
    imageSrc: `051고등어.jpg`
  },
  {
    audioSrc: `052조기.mp3`,
    imageSrc: `052조기.jpg`
  },
  {
    audioSrc: `053식빵.mp3`,
    imageSrc: `053식빵.jpeg`
  },
  {
    audioSrc: `054바게트.mp3`,
    imageSrc: `054바게트.jpg`
  },
  {
    audioSrc: `055비데.mp3`,
    imageSrc: `055비데.jpeg`
  },
  {
    audioSrc: `056커튼.mp3`,
    imageSrc: `056커튼.jpg`
  },
  {
    audioSrc: `057진미채.mp3`,
    imageSrc: `057진미채.jpg`
  },
  {
    audioSrc: `058간장게장.mp3`,
    imageSrc: `058간장게장.jpeg`
  },
  {
    audioSrc: `059비빔밥.mp3`,
    imageSrc: `059비빔밥.jpg`
  },
  {
    audioSrc: `060제육볶음.mp3`,
    imageSrc: `060제육볶음.jpeg`
  },
  {
    audioSrc: `061소주.mp3`,
    imageSrc: `061소주.jpg`
  },
  {
    audioSrc: `062청소기.mp3`,
    imageSrc: `062청소기.jpg`
  },
  {
    audioSrc: `063선풍기.mp3`,
    imageSrc: `063선풍기.jpg`
  },
  {
    audioSrc: `064물.mp3`,
    imageSrc: `064물.jpg`
  },
  {
    audioSrc: `065양말.mp3`,
    imageSrc: `065양말.jpg`
  },
  {
    audioSrc: `066수건.mp3`,
    imageSrc: `066수건.jpeg`
  },
  {
    audioSrc: `067실내화.mp3`,
    imageSrc: `067실내화.jpg`
  },
  {
    audioSrc: `068비누.mp3`,
    imageSrc: `068비누.jpg`
  },
  {
    audioSrc: `069지갑.mp3`,
    imageSrc: `069지갑.jpg`
  },
  {
    audioSrc: `070학교.mp3`,
    imageSrc: `070학교.jpg`
  },
  {
    audioSrc: `071학생.mp3`,
    imageSrc: `071학생.jpg`
  },
  {
    audioSrc: `072볼펜.mp3`,
    imageSrc: `072볼펜.jpeg`
  },
  {
    audioSrc: `073연필.mp3`,
    imageSrc: `073연필.jpg`
  },
  {
    audioSrc: `074정수기.mp3`,
    imageSrc: `074정수기.jpg`
  },
  {
    audioSrc: `075화장실.mp3`,
    imageSrc: `075화장실.png`
  },
  {
    audioSrc: `076샤워기.mp3`,
    imageSrc: `076샤워기.jpg`
  },
  {
    audioSrc: `077세탁기.mp3`,
    imageSrc: `077세탁기.jpg`
  },
  {
    audioSrc: `078휴지.mp3`,
    imageSrc: `078휴지.jpg`
  },
  {
    audioSrc: `079등산.mp3`,
    imageSrc: `079등산.jpg`
  },
  {
    audioSrc: `080커피.mp3`,
    imageSrc: `080커피.jpg`
  },
  {
    audioSrc: `081변기.mp3`,
    imageSrc: `081변기.jpg`
  },
  {
    audioSrc: `082핸드폰.mp3`,
    imageSrc: `082핸드폰.jpg`
  },
  {
    audioSrc: `083믹서기.mp3`,
    imageSrc: `083믹서기.jpg`
  },
  {
    audioSrc: `084라면.mp3`,
    imageSrc: `084라면.jpg`
  },
  {
    audioSrc: `085미역국.mp3`,
    imageSrc: `085미역국.jpg`
  },
  {
    audioSrc: `086생일.mp3`,
    imageSrc: `086생일.jpg`
  },
  {
    audioSrc: `087충전기.mp3`,
    imageSrc: `087충전기.jpeg`
  },
  {
    audioSrc: `088마스크.mp3`,
    imageSrc: `088마스크.jpg`
  },
  {
    audioSrc: `089텔레비전.mp3`,
    imageSrc: `089텔레비전.png`
  },
  {
    audioSrc: `090고추장.mp3`,
    imageSrc: `090고추장.jpg`
  },
  {
    audioSrc: `091고추.mp3`,
    imageSrc: `091고추.jpg`
  },
  {
    audioSrc: `092감기.mp3`,
    imageSrc: `092감기.jpg`
  },
  {
    audioSrc: `093카톡.mp3`,
    imageSrc: `093카톡.png`
  },
  {
    audioSrc: `094인터넷.mp3`,
    imageSrc: `094인터넷.jpeg`
  },
  {
    audioSrc: `095종아리.mp3`,
    imageSrc: `095종아리.jpg`
  },
  {
    audioSrc: `096버섯.mp3`,
    imageSrc: `096버섯.jpeg`
  },
  {
    audioSrc: `097비행기.mp3`,
    imageSrc: `097비행기.jpg`
  },
  {
    audioSrc: `098공항.mp3`,
    imageSrc: `098공항.jpg`
  },
  {
    audioSrc: `099손목.mp3`,
    imageSrc: `099손목.jpg`
  },
  {
    audioSrc: `100양파.mp3`,
    imageSrc: `100양파.jpg`
  },
  {
    audioSrc: `101맥주.mp3`,
    imageSrc: `101맥주.jpg`
  },
  {
    audioSrc: `102우산.mp3`,
    imageSrc: `102우산.jpeg`
  },
  {
    audioSrc: `103치킨.mp3`,
    imageSrc: `103치킨.jpg`
  },
  {
    audioSrc: `104주차장.mp3`,
    imageSrc: `104주차장.jpg`
  },
  {
    audioSrc: `105오이.mp3`,
    imageSrc: `105오이.png`
  },
  {
    audioSrc: `106새우.mp3`,
    imageSrc: `106새우.jpg`
  },
  {
    audioSrc: `107짬뽕.mp3`,
    imageSrc: `107짬뽕.jpg`
  },
  {
    audioSrc: `108돈까스.mp3`,
    imageSrc: `108돈까스.jpg`
  },
  {
    audioSrc: `109크리스마스.mp3`,
    imageSrc: `109크리스마스.jpg`
  },
  {
    audioSrc: `110겨울.mp3`,
    imageSrc: `110겨울.jpg`
  },
  {
    audioSrc: `111사이다.mp3`,
    imageSrc: `111사이다.jpg`
  },
  {
    audioSrc: `112자물쇠.mp3`,
    imageSrc: `112자물쇠.png`
  },
  {
    audioSrc: `113와이셔츠.mp3`,
    imageSrc: `113와이셔츠.jpg`
  },
  {
    audioSrc: `114유모차.mp3`,
    imageSrc: `114유모차.jpg`
  },
  {
    audioSrc: `115리모컨.mp3`,
    imageSrc: `115리모컨.jpeg`
  },
  {
    audioSrc: `116차키.mp3`,
    imageSrc: `116차키.png`
  },
  {
    audioSrc: `117포크레인.mp3`,
    imageSrc: `117포크레인.png`
  },
  {
    audioSrc: `118해수욕장.mp3`,
    imageSrc: `118해수욕장.jpg`
  },
  {
    audioSrc: `119오뎅.mp3`,
    imageSrc: `119오뎅.jpg`
  },
  {
    audioSrc: `120포도.mp3`,
    imageSrc: `120포도.jpeg`
  },
  {
    audioSrc: `121독수리.mp3`,
    imageSrc: `121독수리.png`
  },
  {
    audioSrc: `122뱀.mp3`,
    imageSrc: `122뱀.jpg`
  },
  {
    audioSrc: `123고속도로.mp3`,
    imageSrc: `123고속도로.jpg`
  },
  {
    audioSrc: `124헬리콥터.mp3`,
    imageSrc: `124헬리콥터.jpg`
  },
  {
    audioSrc: `125코다리.mp3`,
    imageSrc: `125코다리.jpg`
  },
  {
    audioSrc: `126계란말이.mp3`,
    imageSrc: `126계란말이.jpg`
  },
  {
    audioSrc: `127계란찜.mp3`,
    imageSrc: `127계란찜.jpeg`
  },
  {
    audioSrc: `128장화.mp3`,
    imageSrc: `128장화.jpg`
  },
  {
    audioSrc: `129엘리베이터.mp3`,
    imageSrc: `129엘리베이터.jpg`
  },
  {
    audioSrc: `130택시.mp3`,
    imageSrc: `130택시.jpg`
  },
  {
    audioSrc: `131세면대.mp3`,
    imageSrc: `131세면대.jpeg`
  },
  {
    audioSrc: `132무지개.mp3`,
    imageSrc: `132무지개.jpg`
  },
  {
    audioSrc: `133소방차.mp3`,
    imageSrc: `133소방차.jpg`
  },
  {
    audioSrc: `134경찰차.mp3`,
    imageSrc: `134경찰차.png`
  },
  {
    audioSrc: `135구급차.mp3`,
    imageSrc: `135구급차.png`
  },
  {
    audioSrc: `136플라스틱.mp3`,
    imageSrc: `136플라스틱.jpg`
  },
  {
    audioSrc: `137경운기.mp3`,
    imageSrc: `137경운기.jpg`
  },
  {
    audioSrc: `138토마토.mp3`,
    imageSrc: `138토마토.png`
  },
  {
    audioSrc: `139사과.mp3`,
    imageSrc: `139사과.jpg`
  },
  {
    audioSrc: `140침대.mp3`,
    imageSrc: `140침대.jpg`
  },
  {
    audioSrc: `141시계.mp3`,
    imageSrc: `141시계.jpg`
  },
  {
    audioSrc: `142치약.mp3`,
    imageSrc: `142치약.jpeg`
  },
  {
    audioSrc: `143욕조.mp3`,
    imageSrc: `143욕조.jpeg`
  },
  {
    audioSrc: `144안마기.mp3`,
    imageSrc: `144안마기.png`
  },
  {
    audioSrc: `145카드.mp3`,
    imageSrc: `145카드.jpeg`
  },
  {
    audioSrc: `146망고.mp3`,
    imageSrc: `146망고.jpeg`
  },
  {
    audioSrc: `147바나나.mp3`,
    imageSrc: `147바나나.jpg`
  },
  {
    audioSrc: `148사거리.mp3`,
    imageSrc: `148사거리.jpg`
  },
  {
    audioSrc: `149ktx.mp3`,
    imageSrc: `149KTX.jpg`
  },
  {
    audioSrc: `150유람선.mp3`,
    imageSrc: `150유람선.jpg`
  },
  {
    audioSrc: `151독도.mp3`,
    imageSrc: `151독도.jpg`
  }
]
