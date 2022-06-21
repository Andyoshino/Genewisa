<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserToken extends Model
{
    use HasFactory;
    
    public $timestamps = false;
    
    protected $table = "user_token";

    protected $primaryKey = 'token';
    public $incrementing = false;
    
    protected $fillable = ['token', 'username'];
}