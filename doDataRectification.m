function subjectData = doDataRectification(subjectData)
   % rectification for condition A  
   subjectData.A = abs(subjectData.A);

   % rectification for condition B 
   subjectData.B = abs(subjectData.B);

   % rectification for condition C 
   subjectData.C = abs(subjectData.C);

end