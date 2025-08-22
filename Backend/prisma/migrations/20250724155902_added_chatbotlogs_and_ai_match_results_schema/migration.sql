-- CreateTable
CREATE TABLE "ai_match_results" (
    "match_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "pwd_id" INTEGER NOT NULL,
    "overall_score" DOUBLE PRECISION NOT NULL,
    "skills_match_score" DOUBLE PRECISION NOT NULL,
    "experience_match_score" DOUBLE PRECISION NOT NULL,
    "location_match_score" DOUBLE PRECISION NOT NULL,
    "accessibility_match_score" DOUBLE PRECISION NOT NULL,
    "matched_on" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ai_match_results_pkey" PRIMARY KEY ("match_id")
);

-- CreateTable
CREATE TABLE "chatbot_logs" (
    "log_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    "response" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chatbot_logs_pkey" PRIMARY KEY ("log_id")
);

-- AddForeignKey
ALTER TABLE "ai_match_results" ADD CONSTRAINT "ai_match_results_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job_Listings"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_match_results" ADD CONSTRAINT "ai_match_results_pwd_id_fkey" FOREIGN KEY ("pwd_id") REFERENCES "Pwd_Profile"("pwd_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chatbot_logs" ADD CONSTRAINT "chatbot_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
