(* Copyright (C) 2005 Pawel Findeisen
 *
 * This file is part of the Dule compiler.
 * The Dule compiler is released under the GNU General Public License (GPL).
 * Please see the file Dule-LICENSE for license information.
 *
 * $Id: dags6.ml,v 1.1 2005/05/22 21:36:22 mikon Exp $
 *)

let nn = int_of_string Sys.argv.(1) in
let rec declarations n acc = 
    if n=0 then
	acc
    else
	declarations
	    (n-1) ("let id"::(string_of_int n)::" = fun ~x -> x in\n"::acc)
in

let rec header n acc = 
    if n=0 then
	"\nfun"::acc
    else
	header (n-1) (" ~id"::(string_of_int n)::acc)
in

let rec condition n acc =
    if n=0 then
	"id"::(string_of_int nn)::acc
    else
	"("::(condition (n-1) (" ~x:id"::(string_of_int (nn-n))::")"::acc))
in

let rec application n acc =
    if n=0 then
	" f"::acc
    else
	application (n-1) (" ~id"::(string_of_int n)::acc)
in

let application = [] in
let condition = condition (nn-1) (" ~x\n"::application) in
let header = header nn (" ~x ->\n"::condition) in
let declarations = "(fun ~t -> {}) ~t:\n" :: header in
List.iter print_string declarations;;
