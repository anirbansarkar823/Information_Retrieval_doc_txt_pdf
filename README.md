This project was mainly based on information retrieval and document indexing using TF-IFD. We have used JSP for the backend of the application.

The work was primarily a part of our DRDO internship. We have applied the TF-IDF algorithm on 3 different kinds of documents (.doc/.docx, .pdf, .txt).



## Database name: jdbc:mysql

## Tables:
      1. relevant_words( doc_name, words, frequency, total_words) (varchar2, varchar2, varchar2, INT)
sample_set_files: common folder for all documents.

## data sturctures used:
       Arraylist, HashMap, Arrays, StringBuilders


** delete_all_from_database.jsp:
- deletes all rows of table 'relevant_words_docs' using doc_id; doc_id being supplied to prepareStatement using a for loop running from i=1 to i=66



1. text_files:

- index.html: when we put any query, based on its relevant words docs will be ranked and presented in their decreasing/non-increasing order or respective ranks.

- forward_indexing.jsp: connection to database using jdbc; 
                        defining a String[] of stopwards; 
                        separating out .txt files using logic 
	                           if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("txt")));
                        a hashmap to store relevant words (words left after removal of stopwords) and corresponding frequencies.
                        storing values into relevant_words table as
                                   doc_name - fileName; words - string of all relevant words; frequency - string of corresponding word freqs; total_words - wordcounts including stopwords

- idf_table.jsp:   target was to take a query from user, and using the relevant words from the query print a table (html) with [relevant words x  idf val]
                   we used the relevant_words database table to fetch the stored words and frequencies for all docs
                   for each relevant words in query, 
                      finding out the ratio = math.log((total text docs) / (docs with current relevant word + 1)) [to avoid infynity]


- inverted_index.jsp: this program is logically same as idf_table.jsp; but here instead of printing a table we print for each relevant word w_i from query
                       doc_name_j (frequency of occurrance of ith relevant word).... 
                       i.e., word = all documents in which the word occurred with corresponding frequency


- reading_multiple_txt_files_p2.jsp: reading multiple text file from sample_set_files, and printing the contents line-by-line.


- reading_single_txt_file.jsp: reading a text file from sample_set_files, and printing the contents line-by-line.


- tf_table.jsp: target was to take a query from user, and using the relevant words from the query print a table (html) with [query relevant word --> doc_name x tf_val]
                   we used the relevant_words database table to fetch the stored words and frequencies for all docs
                   for each relevant words in query, 
                        finding out the ratio = frequency[j]/Total_words[j]; for jth doc holding the relevant query word


- tfidf_final.jsp**:
                   N.B: tf, idf - are calculated for relevant words from query; but tfidf is calulated for documents

                   tf_map stores [relevant_query_word_i : mapOf[all_doc_names:frequency_of_relevant_query_word_in_each_doc]]
                   map_idf stores [relevant_query_word_i : corresponding idf value]
                   tfidf_map stores the [doc_name : corresponding tfidf value] *
                   
                   the filling of tfidf_map is very interesting. Here for each relevant_query_word say i
                   we fetch corresponding idf value
                   then we traverse the tf_map for ith relevant_query_word, and fill corresponding doc names as key of tfidf_map and 
                   for each doc_name the tf is multiplied with idf value and put as value for tfidf_map[doc_j]

                   now for next relevant_query_word, if the same doc_j happens to be there, then the tfidf_map[doc_j] += new_idf * new_tf

                   So basically, as doc_name's corresponding value keeps increasing on getting more relevant_query_word**


                   Now sort the docs based on their corresponding tfidf_values (in non-increasing order) inside map tfidf_map (used a new hashmap to store the sorted docs named r_tfidf_map [tfidf_val : doc_name]. 

                   Based upon this map, we put corresponding links to real documents (as per their relevance)




2. doc_files:
	
	** similar to text_files logic, just need few libraries for reading doc files:

		<%@page import= "org.apache.poi.hwpf.HWPFDocument"%>
                <%@page import= "org.apache.poi.hwpf.extractor.WordExtractor"%>
                <%@page import= "org.apache.poi.xwpf.usermodel.XWPFDocument"%>
                <%@page import= "org.apache.poi.xwpf.usermodel.XWPFParagraph"%>


		HWPFDocument doc = new HWPFDocument(fis);
            	WordExtractor we = new WordExtractor(doc);
		Scanner scnn = new Scanner(we.getText());




3. pdf_files:
	** similar to text_files logic, just need few libraries for reading pdf files:

	<%@page import = "org.apache.pdfbox.pdmodel.PDDocument"%>
        <%@page import = "org.apache.pdfbox.text.PDFTextStripper"%>

        					 
        PDDocument doc = PDDocument.load(file);
        PDFTextStripper pdfStripper = new PDFTextStripper();
        String text = pdfStripper.getText(doc);
        Scanner scnn = new Scanner(text);


