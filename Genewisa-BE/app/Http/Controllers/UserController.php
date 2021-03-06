<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if (isset($request->keyword)) {
            return $this::searchByKeyword($request->keyword);
        }
        $users = User::paginate(10);
        return (new ResponseController)->toResponse($users, 200);
    }


    /**
     * Display a listing of the resource by id.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function view($username)
    {
        $user = User::find($username);

        if (isset($user)) {
            return (new ResponseController)->toResponse($user, 200);
        }

        return (new ResponseController)->toResponse($user, 404, ["User dengan username " . $username . " tidak dapat ditemukan..."]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // return view form create
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $image="";

        $images=array(
            "https://i.imgur.com/eVAwKPb.png",
            "https://i.imgur.com/6loORhj.png",
            "https://i.imgur.com/5BzoAbV.png", 
            "https://i.imgur.com/grs05yK.png", 
            "https://i.imgur.com/b6gPRRu.png", 
            "https://i.imgur.com/T0lr23r.png"
        );
        $b = rand(1,10);
        if ($b <= 2){
            $image = "https://i.imgur.com/BpWouf3.png";
        }else{
            $image = $images[array_rand($images,1)];
        }

        $values = array(
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'img' => $image
        );

        $rules = [
            'username' => 'required',
            'password' => 'required',
            'first_name' => 'required'
        ];
        $errormsg = [
            'required' => 'username/password/firstname harus diisi'
        ];
        $validation = Validator::make($values, $rules, $errormsg);
        $user = User::find($request->username);
        if (isset($user)) {
            return (new ResponseController)->toResponse(null, 400, ["username sudah dipakai!"]);
        }
        if ($validation->fails()) {
            return (new ResponseController)->toResponse(null, 400, ["ada field kosong!"]);
        }
        return (new ResponseController)->toResponse(User::create($values), 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(User $user)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function edit($username)
    {
        $user = User::find($username);
        // return view edit form
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  Illuminate\Http\Request  $request
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update($username, Request $request)
    {

        $user = User::find($username);

        if (! Hash::check($request->passwordlama, $user->password)){
            return (new ResponseController)->toResponse(null, 400, ['password salah...']);
        }
        if (!isset($user)) {
            return (new ResponseController)->toResponse($user, 404, ["User dengan username " . $username . " tidak dapat ditemukan..."]);
        }

        if (isset($request->username)) {
            $usertemp = User::find($request->username);
            if (isset($usertemp) && $user->username != $usertemp->username) {
                return (new ResponseController)->toResponse(null, 400, ["username sudah dipakai!"]);
            }
            $user->username = $request->username;
        }
        if (isset($request->first_name)) {
            $user->first_name = $request->first_name;
        }
        $user->last_name = $request->last_name;
        if (isset($request->passwordbaru)) {
            $user->password = Hash::make($request->passwordbaru);
        }
        $user->save();
        return (new ResponseController)->toResponse($user, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function delete($username)
    {
        $user = User::find($username);

        if (isset($user)) {
            return (new ResponseController)->toResponse($user->delete(), 200);
        }

        return (new ResponseController)->toResponse(null, 404, ["User dengan username " . $username . " tidak dapat ditemukan..."]);
    }

    private static function searchByKeyword($keyword)
    {
        $user = User::where('username', 'LIKE', '%' .$keyword. '%')->orWhere('first_name', 'LIKE', '%' .$keyword. '%')->orWhere('last_name', 'LIKE', '%' .$keyword. '%')->paginate(10);
        return (new ResponseController)->toResponse($user, 200);
    }
}
