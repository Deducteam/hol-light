(****************************************************************************)
(* Definitions shared between all files for Dedukti/Lambdapi export. *)
(****************************************************************************)

#use "topfind";;
#require "camlp5";;
#load "camlp5o.cma";;
#load "unix.cma";;
#load "str.cma";;

(* We use Printf since it is more efficient than Format. *)

(* [out oc s args] outputs [s] with [args] on out_channel [oc]. *)
let out = Printf.fprintf;;

(* [log oc s args] outputs [s] with [args] on stdout. *)
let log = Printf.printf;;

(* [time_of p] executes [p:unit -> unit] and prints on stdout the time
   taken to execute [p]. *)
let time_of p =
  let t0 = Sys.time() in
  p();
  let t1 = Sys.time() in
  log "time: %f s\n" (t1 -. t0)
;;

(* [print_time()] prints on stout the time elapsed since the last call
   to [rpint_time()]. *)
let print_time =
  let t = ref (Sys.time()) in
  fun () ->
  let t' = Sys.time() in log "time: %f s\n" (t' -. !t); t := t'
;;

(* Maps on integers. *)
module OrdInt = struct type t = int let compare = (-) end;;
module MapInt = Map.Make(OrdInt);;

(* [map_thm_id_name] is used to hold the map from theorem numbers to
   theorem names. *)
let map_thm_id_name = ref MapInt.empty;;

(* Maps and sets on strings. *)
module OrdStr = struct type t = string let compare = compare end;;
module MapStr = Map.Make(OrdStr);;
module SetStr = Set.Make(OrdStr);;

(* [map_thm_name_id] is used to hold the map from theorem names to
   theorem numbers. *)
let map_thm_name_id = ref MapStr.empty;;

(* [map_const_typ_vars_pos] is used to hold a map from constant names
   to the positions of type variables in the types of the constants. *)
let map_const_typ_vars_pos = ref MapStr.empty;;

(* [map_file_thms] is used to hold the map from file names to theorem
   names. *)
let map_file_thms = ref MapStr.empty;;

(* [map_file_deps] is used to hold the dependency graph of HOL-Light
   files, that is, the map from file names to their dependencies. *)
let map_file_deps = ref MapStr.empty;;

(* [el_added] indicates whether the constant "el" has been added. *)
let el_added = ref false;
