/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// admin 초기화
admin.initializeApp();

/**새 영상이 있는지 listen -> 데이터베이스에 추가 -> 추가적인 정보를 영상에 추가
 * document() : listen 할 데이터베이스 경로 입력
 * {videoId} : 변수처럼 작동 -> onCreate 로 값이 생성될 때 알림을 받음
 * onCreate() : snapshot(생성된 document), context(어떤 document 가 생성되었는지 videoId 정보 얻을 수 있음) 파라미터
 */
export const onVideoCreated = functions
    .firestore.document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
        // snapshot : 방금 만들어진 영상을 의미 (ref 로 document 에 접근 가능)
        snapshot.ref.update({ "hello": "from functions" });
});